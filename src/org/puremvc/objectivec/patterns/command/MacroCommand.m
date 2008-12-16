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

/**
 * Static Convenience Constructor. 
 */
+(id)command {
	return [[[self alloc] init] autorelease];
}

/**
 * Constructor. 
 * 
 * <P>
 * You should not need to define a constructor, 
 * instead, override the <code>initializeMacroCommand</code>
 * method.</P>
 * 
 * <P>
 * If your subclass does define a constructor, be 
 * sure to call <code>[super init]</code>.</P>
 */
-(id)init {
	if (self = [super init]) {
		self.subCommands = [NSMutableArray array];
		[self initializeMacroCommand];
	}
	return self;
}

/**
 * Initialize the <code>MacroCommand</code>.
 * 
 * <P>
 * In your subclass, override this method to 
 * initialize the <code>MacroCommand</code>'s <i>SubCommand</i>  
 * list with <code>ICommand</code> class references like 
 * this:</P>
 * 
 * @code
 *		// Initialize MyMacroCommand
 *		-(void)initializeMacroCommand {
 *			[self addSubCommand:[FirstCommand class]];
 *			[self addSubCommand:[SecondCommand class]];
 *			[self addSubCommand:[ThirdCommand class]];
 *		}
 * @endcode
 * 
 * <P>
 * Note that <i>SubCommand</i>s may be any <code>ICommand</code> implementor,
 * <code>MacroCommand</code>s or <code>SimpleCommands</code> are both acceptable.
 */
-(void)initializeMacroCommand {
}

/**
 * Add a <i>SubCommand</i>.
 * 
 * <P>
 * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
 * order.</P>
 * 
 * @param commandClassRef a reference to the <code>Class</code> of the <code>ICommand</code>.
 */
-(void)addSubCommand:(Class)commandClassRef {
	[subCommands addObject:commandClassRef];
}

/** 
 * Execute this <code>MacroCommand</code>'s <i>SubCommands</i>.
 * 
 * <P>
 * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
 * order. 
 * 
 * @param notification the <code>INotification</code> object to be passsed to each <i>SubCommand</i>.
 */
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
