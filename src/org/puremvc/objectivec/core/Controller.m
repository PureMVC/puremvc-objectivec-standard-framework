//
//  Controller.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Controller.h"
#import "View.h"
#import "Observer.h"

static id<IController> instance;

@implementation Controller

@synthesize commandMap, view;

-(id)init {
	if (instance != nil) {
		[NSException raise:@"Controller Singleton already constructed! Use getInstance instead." format:nil];
	} else if (self = [super init]) {
		self.commandMap = [NSMutableDictionary dictionary];
		[self initializeController];
	}
	return self;
}

+(id<IController>)getInstance {
	if (instance == nil) {
		instance = [[self alloc] init];
	}
	return instance;
}

-(void)initializeController {
	self.view = [View getInstance];
}

-(void)executeCommand:(id<INotification>)notification {
	Class commandClassRef = [commandMap objectForKey:[notification getName]];
	if (commandClassRef == nil) {
		return;
	}
	[[[[commandClassRef alloc] init] autorelease] execute:notification];
}

-(BOOL)hasCommand:(NSString *)notificationName {
	return [commandMap objectForKey:notificationName] != nil;
}

-(void)registerCommand:(NSString *)notificationName commandClassRef:(Class)commandClassRef {
	if ([commandMap objectForKey:notificationName] == nil) {
		id<IObserver> observer = [Observer withNotifyMethod:@selector(executeCommand:) notifyContext:self];
		[view registerObserver:notificationName observer:observer];
	}
	[commandMap setObject:commandClassRef forKey:notificationName];
}

-(void)removeCommand:(NSString *)notificationName {
	if ([self hasCommand:notificationName]) {
		[view removeObserver:notificationName notifyContext:self];
		[commandMap removeObjectForKey:notificationName];
	}
}

-(void)dealloc {
	self.commandMap = nil;
	self.view = nil;
	[instance release];
	instance = nil;
	[super dealloc];
}

@end
