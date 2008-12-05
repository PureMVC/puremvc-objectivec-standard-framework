//
//  Interfaces.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>

@protocol INotification
-(id)getBody;
-(NSString *)getName;
-(NSString *)getType;
-(void)setBody:(id)body;
-(void)setType:(NSString *)type;
-(NSString *)description;
@end

@protocol IProxy
-(id)getData;
-(NSString *)getProxyName;
-(void)onRegister;
-(void)onRemove;
-(void)setData:(id)data;
@end

@protocol ICommand
-(void)execute:(id<INotification>)notification;
@end

@protocol IController
-(void)executeCommand:(id<INotification>)notification;
-(BOOL)hasCommand:(NSString *)notificationName;
-(void)registerCommand:(NSString *)notificationName commandClassRef:(Class)commandClassRef;
-(void)removeCommand:(NSString *)notificationName;
@end

@protocol IMediator
-(NSString *)getMediatorName;
-(id)getViewComponent;
-(void)handleNotification:(id<INotification>)notification;
-(NSArray *)listNotificationInterests;
-(void)onRegister;
-(void)onRemove;
-(void)setViewComponent:(id)viewComponent;
@end

@protocol IModel
-(BOOL)hasProxy:(NSString *)proxyName;
-(void)registerProxy:(id<IProxy>)proxy;
-(id<IProxy>)removeProxy:(NSString *)proxyName;
-(id<IProxy>)retrieveProxy:(NSString *)proxyName;
@end

@protocol INotifier
-(void)sendNotification:(NSString *)notificationName body:(id)body type:(NSString *)type;
@end

@protocol IObserver
-(BOOL)compareNotifyContext:(id)object;
-(void)notifyObserver:(id<INotification>)notification;
-(void)setNotifyContext:(id)notifyContext;
-(void)setNotifyMethod:(SEL)notifyMethod;
@end

@protocol IView
-(BOOL)hasMediator:(NSString *)mediatorName;
-(void)notifyObservers:(id<INotification>)notification;
-(void)registerMediator:(id<IMediator>)mediator;
-(void)registerObserver:(NSString *)notificationName observer:(id<IObserver>)observer;
-(id<IMediator>)removeMediator:(NSString *)mediatorName;
-(void)removeObserver:(NSString *)notificationName notifyContext:(id)notifyContext;
-(id<IMediator>)retrieveMediator:(NSString *)mediatorName;
@end

@protocol IFacade
-(BOOL)hasCommand:(NSString *)notificationName;
-(BOOL)hasMediator:(NSString *)mediatorName;
-(BOOL)hasProxy:(NSString *)proxyName;
-(void)notifyObservers:(id<INotification>)notification;
-(void)registerCommand:(NSString *)notificationName commandClassRef:(Class)commandClassRef;
-(void)registerMediator:(id<IMediator>)mediator;
-(void)registerProxy:(id<IProxy>)proxy;
-(void)removeCommand:(NSString *)notificationName;
-(id<IMediator>)removeMediator:(NSString *)mediatorName;
-(id<IProxy>)removeProxy:(NSString *)proxyName;
-(id<IMediator>)retrieveMediator:(NSString *)mediatorName;
-(id<IProxy>)retrieveProxy:(NSString *)proxyName;
-(void)sendNotification:(NSString *)notificationName body:(id)body type:(NSString *)type;
@end
