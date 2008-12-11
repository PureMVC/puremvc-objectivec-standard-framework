//
//  Proxy.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"
#import "Notifier.h"

@interface Proxy : Notifier <IProxy> {
	id data;
	NSString *proxyName;
}

@property(nonatomic, retain) id data;
@property(nonatomic, retain) NSString *proxyName;

+(id)proxy;
+(id)withProxyName:(NSString *)proxyName;
+(id)withProxyName:(NSString *)proxyName data:(id)data;
+(id)withData:(id)data;
-(id)initWithProxyName:(NSString *)proxyName data:(id)data;
-(void)initializeProxy;

+(NSString *)NAME;

@end
