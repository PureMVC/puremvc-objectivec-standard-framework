//
//  View.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "View.h"
#import "Observer.h"

static id<IView> instance;

@implementation View

@synthesize mediatorMap, observerMap;

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

+(id<IView>)getInstance {
	if (instance == nil) {
		instance = [[self alloc] init];
	}
	return instance;
}

-(void)initializeView {
}


-(BOOL)hasMediator:(NSString *)mediatorName {
	return [mediatorMap objectForKey:mediatorName] != nil;
}

-(void)notifyObservers:(id<INotification>)notification {
	NSMutableArray *observers = [observerMap objectForKey:[notification getName]];
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

-(void)registerMediator:(id<IMediator>)mediator {
	if ([mediatorMap objectForKey:[mediator getMediatorName]] != nil) {
		return;
	}
	[mediatorMap setObject:mediator	forKey:[mediator getMediatorName]];
	NSArray *interests = [mediator listNotificationInterests];
	if ([interests count] > 0) {
		id<IObserver> observer = [Observer withNotifyMethod:@selector(handleNotification:) notifyContext:mediator];
		for (NSString *notificationName in interests) {
			[self registerObserver:notificationName observer:observer];
		}
	}
	[mediator onRegister];
}

-(void)registerObserver:(NSString *)notificationName observer:(id<IObserver>)observer {
	NSMutableArray *observers = [observerMap objectForKey:notificationName];
	if (observers == nil) {
		observers = [NSMutableArray array];
		[observerMap setObject:observers forKey:notificationName];
	} 
	[observers addObject:observer];
}


-(id<IMediator>)removeMediator:(NSString *)mediatorName {
	id<IMediator> mediator = [mediatorMap objectForKey:mediatorName];
	if (mediator != nil) {
		NSArray *interests = [mediator listNotificationInterests];
		for (NSString *notificationName in interests) {
			[self removeObserver:notificationName notifyContext:mediator];
		}
		[mediatorMap removeObjectForKey:mediatorName];
		[mediator onRemove];
	}
	return mediator;
}


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
