//
//  Facade.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Facade.h"
#import "Model.h"
#import "View.h"
#import "Controller.h"
#import "Notification.h"

static id<IFacade> instance;

@implementation Facade

@synthesize model, controller, view;

-(id)init {
	if (instance != nil) {
		[NSException raise:@"Facade Singleton already constructed! Use getInstance instead." format:nil];
	} else if (self = [super init]) {
		[self initializeFacade];
	}
	return self;
}

+(id<IFacade>)getInstance {
	if (instance == nil) {
		instance = [[self alloc] init];
	}
	return instance;
}

-(void)initializeFacade {
	[self initializeModel];
	[self initializeController];
	[self initializeView];
}

-(void)initializeModel {
	if (model != nil) return;
	self.model = [Model getInstance];
}

-(void)initializeController {
	if (controller != nil) return;
	self.controller = [Controller getInstance];
}

-(void)initializeView {
	if (view != nil) return;
	self.view = [View getInstance];
}

-(void)sendNotification:(NSString *)notificationName {
	[self sendNotification:notificationName body:nil type:nil];
}

-(void)sendNotification:(NSString *)notificationName body:(id)body {
	[self sendNotification:notificationName body:body type:nil];
}

-(void)sendNotification:(NSString *)notificationName body:(id)body type:(NSString *)type {
	[self notifyObservers:[Notification withName:notificationName body:body type:type]];
}

-(void)sendNotification:(NSString *)notificationName type:(NSString *)type {
	[self sendNotification:notificationName body:nil type:type];
}

-(BOOL)hasCommand:(NSString *)notificationName {
	return [controller hasCommand:notificationName];
}

-(BOOL)hasMediator:(NSString *)mediatorName {
	return [view hasMediator:mediatorName];
}

-(BOOL)hasProxy:(NSString *)proxyName {
	return [model hasProxy:proxyName];
}

-(void)notifyObservers:(id<INotification>)notification {
	[view notifyObservers:notification];
}

-(void)registerCommand:(NSString *)notificationName commandClassRef:(Class)commandClassRef {
	[controller registerCommand:notificationName commandClassRef:commandClassRef];
}

-(void)registerMediator:(id<IMediator>)mediator {
	[view registerMediator:mediator];
}

-(void)registerProxy:(id<IProxy>)proxy {
	[model registerProxy:proxy];
}

-(void)removeCommand:(NSString *)notificationName {
	[controller removeCommand:notificationName];
}

-(id<IMediator>)removeMediator:(NSString *)mediatorName {
	return [view removeMediator:mediatorName];
}

-(id<IProxy>)removeProxy:(NSString *)proxyName {
	return [model removeProxy:proxyName];
}

-(id<IMediator>)retrieveMediator:(NSString *)mediatorName {
	return [view retrieveMediator:mediatorName];
}

-(id<IProxy>)retrieveProxy:(NSString *)proxyName {
	return [model retrieveProxy:proxyName];
}

-(void)dealloc {
	self.model = nil;
	self.controller = nil;
	self.view = nil;
	[instance release];
	instance = nil;
	[super dealloc];
}

@end
