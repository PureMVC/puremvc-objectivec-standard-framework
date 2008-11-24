//
//  MacroCommand.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"
#import "Notifier.h"

@interface MacroCommand : Notifier <ICommand> {
	NSMutableArray *subCommands;
}

@property(nonatomic, retain) NSMutableArray *subCommands;

-(void)initializeMacroCommand;
-(void)addSubCommand:(Class)commandClassRef;

@end
