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

@interface Mediator : Notifier <IMediator, INotifier> {
	NSString *mediatorName;
	id viewComponent;
}

@property(nonatomic, retain, getter=getViewComponent) id viewComponent;
@property(nonatomic, retain, getter=getMediatorName) NSString *mediatorName;

-(id)initWithMediatorName:(NSString *)mediatorName viewComponent:(id)viewComponent;

@end
