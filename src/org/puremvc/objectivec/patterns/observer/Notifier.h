//
//  Notifier.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"

@interface Notifier : NSObject <INotifier> {
	id<IFacade> facade;
}

@property(nonatomic, retain) id<IFacade> facade;

-(void)sendNotification:(NSString *)notificationName;
-(void)sendNotification:(NSString *)notificationName body:(id)body;
-(void)sendNotification:(NSString *)notificationName type:(NSString *)type;

@end
