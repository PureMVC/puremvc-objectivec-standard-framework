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

-(id)init {
	if (self = [super init]) {
		self.mediatorName = @"Mediator";
	}
	return self;
}

-(id)initWithMediatorName:(NSString *)_mediatorName viewComponent:(id)_viewComponent {
	if (self = [super init]) {
		self.mediatorName = _mediatorName;
		self.viewComponent = _viewComponent;
	}
	return self;
}

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
