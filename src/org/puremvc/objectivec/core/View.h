//
//  View.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"

@interface View : NSObject <IView> {
	NSMutableDictionary *mediatorMap, *observerMap;
}

@property(nonatomic, retain) NSMutableDictionary *mediatorMap, *observerMap;

+(id<IView>)getInstance;
-(void)initializeView;

@end
