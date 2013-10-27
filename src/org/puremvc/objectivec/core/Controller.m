//
//  Controller.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Controller.h"
#import "View.h"
#import "IObserver.h"
#import "Observer.h"
#import "ICommand.h"

static id<IController> instance;

@implementation Controller

@synthesize commandMap, view;

/**
 * Constructor. 
 * 
 * <P>
 * This <code>IController</code> implementation is a Singleton, 
 * so you should not call the constructor 
 * directly, but instead call the static Singleton 
 * Factory method <code>[Controller getInstance]</code>
 * 
 * @throws NSException if Singleton instance has already been constructed
 * 
 */
-(id)init {
	if (instance != nil) {
		[NSException raise:@"Controller Singleton already constructed! Use getInstance instead." format:nil];
	} else if (self = [super init]) {
		self.commandMap = [NSMutableDictionary dictionary];
		[self initializeController];
	}
	return self;
}

/**
 * Initialize the Singleton <code>Controller</code> instance.
 * 
 * <P>Called automatically by the constructor.</P> 
 * 
 * <P>Note that if you are using a subclass of <code>View</code>
 * in your application, you should <i>also</i> subclass <code>Controller</code>
 * and override the <code>initializeController</code> method in the 
 * following way:</P>
 * 
 * @code
 *		// ensure that the Controller is talking to my IView implementation
 *		-(void)initializeController {
 *			self.view = [MyView getInstance];
 *		}
 * @endcode
 * 
 * @return void
 */
-(void)initializeController {
	self.view = [View getInstance];
}

/**
 * <code>Controller</code> Singleton Factory method.
 * 
 * @return the Singleton instance of <code>Controller</code>
 */
+(id<IController>)getInstance {
	if (instance == nil) {
		instance = [[self alloc] init];
	}
	return instance;
}

/**
 * If an <code>ICommand</code> has previously been registered 
 * to handle a the given <code>INotification</code>, then it is executed.
 * 
 * @param notification an <code>INotification</code>
 */
-(void)executeCommand:(id<INotification>)notification {
	Class commandClassRef = [commandMap objectForKey:[notification name]];
	if (commandClassRef == nil) {
		return;
	}
	[(id<ICommand>)[[[commandClassRef alloc] init] autorelease] execute:notification];
}

/**
 * Check if a Command is registered for a given Notification 
 * 
 * @param notificationName
 * @return whether a Command is currently registered for the given <code>notificationName</code>.
 */
-(BOOL)hasCommand:(NSString *)notificationName {
	return [commandMap objectForKey:notificationName] != nil;
}

/**
 * Register a particular <code>ICommand</code> class as the handler 
 * for a particular <code>INotification</code>.
 * 
 * <P>
 * If an <code>ICommand</code> has already been registered to 
 * handle <code>INotification</code>s with this name, it is no longer
 * used, the new <code>ICommand</code> is used instead.</P>
 * 
 * The Observer for the new ICommand is only created if this the 
 * first time an ICommand has been regisered for this Notification name.
 * 
 * @param notificationName the name of the <code>INotification</code>
 * @param commandClassRef the <code>Class</code> of the <code>ICommand</code>
 */
-(void)registerCommand:(NSString *)notificationName commandClassRef:(Class)commandClassRef {
	if ([commandMap objectForKey:notificationName] == nil) {
		id<IObserver> observer = [Observer withNotifyMethod:@selector(executeCommand:) notifyContext:self];
		[view registerObserver:notificationName observer:observer];
	}
	[commandMap setObject:commandClassRef forKey:notificationName];
}

/**
 * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping.
 * 
 * @param notificationName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
 */
-(void)removeCommand:(NSString *)notificationName {
	if ([self hasCommand:notificationName]) {
		[view removeObserver:notificationName notifyContext:self];
		[commandMap removeObjectForKey:notificationName];
	}
}

-(void)dealloc {
	self.commandMap = nil;
	self.view = nil;
	[(id)instance release];
	instance = nil;
	[super dealloc];
}

@end
