//
//  Observer.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"

@interface Observer : NSObject <IObserver> {
	SEL notifyMethod;
	id notifyContext;
}

@property SEL notifyMethod;
@property(nonatomic, retain) id notifyContext;

+(id)withNotifyMethod:(SEL)notifyMethod notifyContext:(id)notifyContext;
-(id)initWithNotifyMethod:(SEL)notifyMethod notifyContext:(id)notifyContext;

@end
