//
//  View.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "View.h"
#import "Observer.h"
#import "IObserver.h"

static id<IView> instance;

@implementation View

@synthesize mediatorMap, observerMap;

/**
 * Constructor. 
 * 
 * <P>
 * This <code>IView</code> implementation is a Singleton, 
 * so you should not call the constructor 
 * directly, but instead call the static Singleton 
 * Factory method <code>[View getInstance]</code>
 * 
 * @throws NSException if Singleton instance has already been constructed
 * 
 */
-(id)init {
	if (instance != nil) {
		[NSException raise:@"View Singleton already constructed! Use getInstance instead." format:nil];
	} else if (self = [super init]) {
		self.mediatorMap = [NSMutableDictionary dictionary];
		self.observerMap = [NSMutableDictionary dictionary];
		[self initializeView];
	}
	return self;
}

/**
 * Initialize the Singleton View instance.
 * 
 * <P>
 * Called automatically by the constructor, this
 * is your opportunity to initialize the Singleton
 * instance in your subclass without overriding the
 * constructor.</P>
 * 
 * @return void
 */
-(void)initializeView {
}

/**
 * View Singleton Factory method.
 * 
 * @return the Singleton instance of <code>View</code>
 */
+(id<IView>)getInstance {
	if (instance == nil) {
		instance = [[self alloc] init];
	}
	return instance;
}

/**
 * Check if a Mediator is registered or not
 * 
 * @param mediatorName
 * @return whether a Mediator is registered with the given <code>mediatorName</code>.
 */
-(BOOL)hasMediator:(NSString *)mediatorName {
	return [mediatorMap objectForKey:mediatorName] != nil;
}

/**
 * Notify the <code>IObservers</code> for a particular <code>INotification</code>.
 * 
 * <P>
 * All previously attached <code>IObservers</code> for this <code>INotification</code>'s
 * list are notified and are passed a reference to the <code>INotification</code> in 
 * the order in which they were registered.</P>
 * 
 * @param notification the <code>INotification</code> to notify <code>IObservers</code> of.
 */
-(void)notifyObservers:(id<INotification>)notification {
	NSMutableArray *observers = [observerMap objectForKey:[notification name]];
	NSMutableArray *workingObservers = [NSMutableArray array];
	if (observers != nil) {
		for (id<IObserver> observer in observers) {
			[workingObservers addObject:observer];
		}
		for (id<IObserver> observer in workingObservers) {
			[observer notifyObserver:notification];
		}
	}
}

/**
 * Register an <code>IMediator</code> instance with the <code>View</code>.
 * 
 * <P>
 * Registers the <code>IMediator</code> so that it can be retrieved by name,
 * and further interrogates the <code>IMediator</code> for its 
 * <code>INotification</code> interests.</P>
 * <P>
 * If the <code>IMediator</code> returns any <code>INotification</code> 
 * names to be notified about, an <code>Observer</code> is created encapsulating 
 * the <code>IMediator</code> instance's <code>handleNotification</code> method 
 * and registering it as an <code>Observer</code> for all <code>INotifications</code> the 
 * <code>IMediator</code> is interested in.</p>
 * 
 * @param mediator a reference to the <code>IMediator</code> instance
 */
-(void)registerMediator:(id<IMediator>)mediator {
	if ([mediatorMap objectForKey:[mediator mediatorName]] != nil) {
		return;
	}
	[mediatorMap setObject:mediator	forKey:[mediator mediatorName]];
	NSArray *interests = [mediator listNotificationInterests];
	if ([interests count] > 0) {
		id<IObserver> observer = [Observer withNotifyMethod:@selector(handleNotification:) notifyContext:mediator];
		for (NSString *notificationName in interests) {
			[self registerObserver:notificationName observer:observer];
		}
	}
	[mediator onRegister];
}

/**
 * Register an <code>IObserver</code> to be notified
 * of <code>INotifications</code> with a given name.
 * 
 * @param notificationName the name of the <code>INotifications</code> to notify this <code>IObserver</code> of
 * @param observer the <code>IObserver</code> to register
 */
-(void)registerObserver:(NSString *)notificationName observer:(id<IObserver>)observer {
	NSMutableArray *observers = [observerMap objectForKey:notificationName];
	if (observers == nil) {
		observers = [NSMutableArray array];
		[observerMap setObject:observers forKey:notificationName];
	} 
	[observers addObject:observer];
}

/**
 * Remove an <code>IMediator</code> from the <code>View</code>.
 * 
 * @param mediatorName name of the <code>IMediator</code> instance to be removed.
 * @return the <code>IMediator</code> that was removed from the <code>View</code>
 */
-(id<IMediator>)removeMediator:(NSString *)mediatorName {
	id<IMediator> mediator = [mediatorMap objectForKey:mediatorName];
	if (mediator != nil) {
		NSArray *interests = [mediator listNotificationInterests];
		for (NSString *notificationName in interests) {
			[self removeObserver:notificationName notifyContext:mediator];
		}
		[mediator onRemove];
		[mediator setViewComponent:nil];
		[mediatorMap removeObjectForKey:mediatorName];
	}
	return mediator;
}

/**
 * Remove the observer for a given notifyContext from an observer list for a given Notification name.
 * <P>
 * @param notificationName which observer list to remove from 
 * @param notifyContext remove the observer with this object as its notifyContext
 */
-(void)removeObserver:(NSString *)notificationName notifyContext:(id)notifyContext {
	NSMutableArray *observers = [observerMap objectForKey:notificationName];
	if (observers != nil) {
		for (id<IObserver> observer in observers) {
			if ([observer compareNotifyContext:notifyContext]) {
				[observers removeObject:observer];
				break;
			}
		}
		if ([observers count] == 0) {
			[observerMap removeObjectForKey:notificationName];
		}
	}
}

/**
 * Retrieve an <code>IMediator</code> from the <code>View</code>.
 * 
 * @param mediatorName the name of the <code>IMediator</code> instance to retrieve.
 * @return the <code>IMediator</code> instance previously registered with the given <code>mediatorName</code>.
 */
-(id<IMediator>)retrieveMediator:(NSString *)mediatorName {
	return [mediatorMap objectForKey:mediatorName];
}

-(void)dealloc {
	self.mediatorMap = nil;
	self.observerMap = nil;
	[(id)instance release];
	instance = nil;
	[super dealloc];
}

@end
