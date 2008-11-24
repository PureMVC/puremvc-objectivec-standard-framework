//
//  SimpleCommandTestCommand.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "TestCommand.h"
#import "TestVO.h"

@implementation TestCommand

-(void)execute:(id<INotification>)notification {
	TestVO *vo = [notification getBody];
	vo.result = 2 * vo.input;
}

@end
