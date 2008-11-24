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

-(void)sendNotification:(NSString *)notificationName body:(id)body type:(NSString *)type {
	[[Facade getInstance] sendNotification:notificationName body:body type:type];
}

@end
