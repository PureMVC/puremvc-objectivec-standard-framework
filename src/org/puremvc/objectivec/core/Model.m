//
//  Model.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Model.h"

static id<IModel> instance;

@implementation Model

@synthesize proxyMap;

/**
 * Constructor. 
 * 
 * <P>
 * This <code>IModel</code> implementation is a Singleton, 
 * so you should not call the constructor 
 * directly, but instead call the static Singleton 
 * Factory method <code>[Model getInstance]</code>
 * 
 * @throws NSException if Singleton instance has already been constructed
 * 
 */
-(id)init {
	if (instance != nil) {
		[NSException raise:@"Model Singleton already constructed! Use getInstance instead." format:nil];
	} else if (self = [super init]) {
		self.proxyMap = [NSMutableDictionary dictionary];
		[self initializeModel];
	}
	return self;
}

/**
 * Initialize the Singleton <code>Model</code> instance.
 * 
 * <P>
 * Called automatically by the constructor, this
 * is your opportunity to initialize the Singleton
 * instance in your subclass without overriding the
 * constructor.</P>
 * 
 * @return void
 */
-(void)initializeModel {
}

/**
 * <code>Model</code> Singleton Factory method.
 * 
 * @return the Singleton instance
 */
+(id<IModel>)getInstance {
	if (instance == nil) {
		instance = [[self alloc] init];
	}
	return instance;
}

/**
 * Check if a Proxy is registered
 * 
 * @param proxyName
 * @return whether a Proxy is currently registered with the given <code>proxyName</code>.
 */
-(BOOL)hasProxy:(NSString *)proxyName {
	return [proxyMap objectForKey:proxyName] != nil;
}

/**
 * Register an <code>IProxy</code> with the <code>Model</code>.
 * 
 * @param proxy an <code>IProxy</code> to be held by the <code>Model</code>.
 */
-(void)registerProxy:(id<IProxy>)proxy {
	[proxyMap setObject:proxy forKey:[proxy proxyName]];
	[proxy onRegister];
}

/**
 * Remove an <code>IProxy</code> from the <code>Model</code>.
 * 
 * @param proxyName name of the <code>IProxy</code> instance to be removed.
 * @return the <code>IProxy</code> that was removed from the <code>Model</code>
 */
-(id<IProxy>)removeProxy:(NSString *)proxyName {
	id<IProxy> proxy = [proxyMap objectForKey:proxyName];
	if (proxy != nil) {
		[proxy onRemove];
		[proxyMap removeObjectForKey:proxyName];
	}
	return proxy;
}

/**
 * Retrieve an <code>IProxy</code> from the <code>Model</code>.
 * 
 * @param proxyName
 * @return the <code>IProxy</code> instance previously registered with the given <code>proxyName</code>.
 */
-(id<IProxy>)retrieveProxy:(NSString *)proxyName {
	return [proxyMap objectForKey:proxyName];
}

-(void)dealloc {
	self.proxyMap = nil;
	[(id)instance release];
	instance = nil;
	[super dealloc];
}

@end
