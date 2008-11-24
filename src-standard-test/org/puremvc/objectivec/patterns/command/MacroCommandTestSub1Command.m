//
//  MacroCommandTestSub1Command.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "MacroCommandTestSub1Command.h"
#import "TestVO.h"

@implementation MacroCommandTestSub1Command

-(void)execute:(id<INotification>)notification {
	TestVO *vo = [notification getBody];
	vo.result1 = 2 * vo.input;
}

@end
