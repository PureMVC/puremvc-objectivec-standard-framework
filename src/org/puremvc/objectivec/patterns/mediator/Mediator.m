//
//  Mediator.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Mediator.h"

@implementation Mediator

@synthesize mediatorName, viewComponent;

+(id)mediator {
	return [[[self alloc] initWithMediatorName:nil viewComponent:nil] autorelease];
}

+(id)withMediatorName:(NSString *)mediatorName {
	return [[[self alloc] initWithMediatorName:mediatorName viewComponent:nil] autorelease];
}

+(id)withMediatorName:(NSString *)mediatorName viewComponent:(id)viewComponent {
	return [[[self alloc] initWithMediatorName:mediatorName viewComponent:viewComponent] autorelease];
}

+(id)withWiewComponent:(id)viewComponent {
	return [[[self alloc] initWithMediatorName:nil viewComponent:viewComponent] autorelease];
}

-(id)initWithMediatorName:(NSString *)_mediatorName viewComponent:(id)_viewComponent {
	if (self = [super init]) {
		self.mediatorName = (_mediatorName == nil) ? [[self class] NAME] : _mediatorName;
		self.viewComponent = _viewComponent;
		[self initializeMediator];
	}
	return self;
}

+(NSString *)NAME {
	return @"Mediator";
}

-(void)initializeMediator {}

-(void)handleNotification:(id<INotification>)notification {}

-(NSArray *)listNotificationInterests {
	return [NSArray array];
}

-(void)onRegister {}

-(void)onRemove {}

-(void)dealloc {
	self.mediatorName = nil;
	self.viewComponent = nil;
	[super dealloc];
}

@end
