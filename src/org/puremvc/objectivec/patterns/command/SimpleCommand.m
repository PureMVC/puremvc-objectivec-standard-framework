//
//  SimpleCommand.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "SimpleCommand.h"


@implementation SimpleCommand

+(id)command {
	return [[[self alloc] init] autorelease];
}

-(void)execute:(id<INotification>)notification {}

@end
