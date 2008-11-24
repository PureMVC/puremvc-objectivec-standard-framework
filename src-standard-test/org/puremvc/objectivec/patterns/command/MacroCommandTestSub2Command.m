//
//  MacroCommandTestSub2Command.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "MacroCommandTestSub2Command.h"
#import "TestVO.h"

@implementation MacroCommandTestSub2Command

-(void)execute:(id<INotification>)notification {
	TestVO *vo = [notification getBody];
	vo.result2 = vo.input * vo.input;
}

@end
