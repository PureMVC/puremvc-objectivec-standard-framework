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

-(id)init {
	if (instance != nil) {
		[NSException raise:@"Model Singleton already constructed! Use getInstance instead." format:nil];
	} else if (self = [super init]) {
		self.proxyMap = [NSMutableDictionary dictionary];
		[self initializeModel];
	}
	return self;
}

+(id<IModel>)getInstance {
	if (instance == nil) {
		instance = [[Model alloc] init];
	}
	return instance;
}

-(void)initializeModel {
}

-(BOOL)hasProxy:(NSString *)proxyName {
	return [proxyMap objectForKey:proxyName] != nil;
}

-(void)registerProxy:(id<IProxy>)proxy {
	[proxyMap setObject:proxy forKey:[proxy getProxyName]];
	[proxy onRegister];
}

-(id<IProxy>)removeProxy:(NSString *)proxyName {
	id<IProxy> proxy = [proxyMap objectForKey:proxyName];
	if (proxy != nil) {
		[proxyMap removeObjectForKey:proxyName];
		[proxy onRemove];
	}
	return proxy;
}

-(id<IProxy>)retrieveProxy:(NSString *)proxyName {
	return [proxyMap objectForKey:proxyName];
}

-(void)dealloc {
	self.proxyMap = nil;
	[instance release];
	instance = nil;
	[super dealloc];
}

@end
