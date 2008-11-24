//
//  Controller.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"

@interface Controller : NSObject <IController> {
	NSMutableDictionary *commandMap;
	id<IView> view;
}

@property(nonatomic, retain) NSMutableDictionary *commandMap;
@property(nonatomic, retain) id<IView> view;

+(id<IController>)getInstance;
-(void)initializeController;

@end
