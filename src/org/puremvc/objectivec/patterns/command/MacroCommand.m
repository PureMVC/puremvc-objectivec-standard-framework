//
//  MacroCommand.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "MacroCommand.h"


@implementation MacroCommand

@synthesize subCommands;

-(id)init {
	if (self = [super init]) {
		self.subCommands = [NSMutableArray array];
		[self initializeMacroCommand];
	}
	return self;
}

-(void)initializeMacroCommand {}

-(void)addSubCommand:(Class)commandClassRef {
	[subCommands addObject:commandClassRef];
}

-(void)execute:(id<INotification>)notification {
	for (Class commandClassRef in subCommands) {
		[[[[commandClassRef alloc] init] autorelease] execute:notification];
	}
}

-(void)dealloc {
	self.subCommands = nil;
	[super dealloc];
}

@end
