//
//  Mediator.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"
#import "Notifier.h"

@interface Mediator : Notifier <IMediator> {
	NSString *mediatorName;
	id viewComponent;
}

@property(nonatomic, retain, getter=getViewComponent) id viewComponent;
@property(nonatomic, retain, getter=getMediatorName) NSString *mediatorName;

+(id)mediator;
+(id)withMediatorName:(NSString *)mediatorName;
+(id)withMediatorName:(NSString *)mediatorName viewComponent:(id)viewComponent;
+(id)withWiewComponent:(id)viewComponent;
-(id)initWithMediatorName:(NSString *)mediatorName viewComponent:(id)viewComponent;
-(void)initializeMediator;

+(NSString *)NAME;

@end
