//
//  MacroCommandTestCommand.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "MacroCommandTestCommand.h"
#import "MacroCommandTestSub1Command.h"
#import "MacroCommandTestSub2Command.h"

@implementation MacroCommandTestCommand

-(void)initializeMacroCommand {
	[self addSubCommand:[MacroCommandTestSub1Command class]];
	[self addSubCommand:[MacroCommandTestSub2Command class]];
}

@end
