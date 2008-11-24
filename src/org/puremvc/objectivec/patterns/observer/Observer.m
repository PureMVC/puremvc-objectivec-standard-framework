//
//  Observer.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Observer.h"


@implementation Observer

@synthesize notifyMethod, notifyContext;

-(id)initWithNotifyMethod:(SEL)_notifyMethod notifyContext:(id)_notifyContext {
	if (self = [super init]) {
		self.notifyMethod = _notifyMethod;
		self.notifyContext = _notifyContext;
	}
	return self;
}

-(BOOL)compareNotifyContext:(id)object {
	return [object isEqual:notifyContext];
}

-(void)notifyObserver:(id<INotification>)notification {
	[notifyContext performSelector:notifyMethod withObject:notification];
}

-(void)dealloc {
	self.notifyMethod = nil;
	self.notifyContext = nil;
	[super dealloc];
}


@end
