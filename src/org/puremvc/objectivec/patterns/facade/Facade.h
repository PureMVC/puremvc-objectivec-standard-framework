//
//  Facade.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"

@interface Facade : NSObject <IFacade> {
	id<IController> controller;
	id<IModel> model;
	id<IView> view;
}

@property(nonatomic, retain) id<IController> controller;
@property(nonatomic, retain) id<IModel> model;
@property(nonatomic, retain) id<IView> view;

+(id<IFacade>)getInstance;
-(void)sendNotification:(NSString *)notificationName body:(id)body type:(NSString *)type;

@end
