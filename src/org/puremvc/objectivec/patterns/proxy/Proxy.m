//
//  Proxy.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Proxy.h"


@implementation Proxy

@synthesize data, proxyName;

-(id)init {
	if (self = [super init]) {
		self.proxyName = @"Proxy";
	}
	return self;
}

-(id)initWithProxyName:(NSString *)_proxyName data:(id)_data {
	if (self = [super init]) {
		self.proxyName = _proxyName;
		self.data = _data;
	}
	return self;
}

-(void)onRegister {}
-(void)onRemove {}

-(void)dealloc {
	self.data = nil;
	self.proxyName = nil;
	[super dealloc];
}

@end
