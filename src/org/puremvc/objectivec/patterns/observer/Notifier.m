//
//  Notifier.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Notifier.h"
#import "Facade.h"

@implementation Notifier

@synthesize facade;

-(id)init {
	if (self = [super init]) {
		self.facade = [Facade getInstance];
	}
	return self;
}

-(void)sendNotification:(NSString *)notificationName {
	[self sendNotification:notificationName body:nil type:nil];
}

-(void)sendNotification:(NSString *)notificationName body:(id)body {
	[self sendNotification:notificationName body:body type:nil];
}

-(void)sendNotification:(NSString *)notificationName body:(id)body type:(NSString *)type {
	[facade sendNotification:notificationName body:body type:type];
}

-(void)sendNotification:(NSString *)notificationName type:(NSString *)type {
	[self sendNotification:notificationName body:nil type:type];
}

-(void)dealloc {
	self.facade = nil;
	[super dealloc];
}

@end
