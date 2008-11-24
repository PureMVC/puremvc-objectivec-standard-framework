//
//  ObserverTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ObserverTest.h"
#import "Observer.h"
#import "Notification.h"

@implementation ObserverTest

-(void)testConstructor {
	
	// Create observer passing in notification method and context
	id<IObserver> observer = [[[Observer alloc] initWithNotifyMethod:@selector(observerTestMethod:) notifyContext:self] autorelease];
	
	// create a test note, setting a body value and notify 
	// the observer with it. since the observer is this class 
	// and the notification method is observerTestMethod,
	// successful notification will result in our local 
	// observerTestVar being set to the value we pass in 
	// on the note body.
	id<INotification> note = [[[Notification alloc] initWithName:@"ObserverTestNote" body:@"5" type:nil] autorelease];
	[observer notifyObserver:note];
	
	// test assertions              
	STAssertTrue([observerTestVar isEqualToString:@"5"], @"observerTestVar should be 5");
}

-(void)testCompareNotifyContext {
	
	// Create observer passing in notification method and context
	id<IObserver> observer = [[[Observer alloc] initWithNotifyMethod:@selector(observerTestMethod:) notifyContext:self] autorelease];
	
	id object = [[[NSObject alloc] init] autorelease];
	
	// test assertions 
	STAssertFalse([observer compareNotifyContext:object], @"should not be equal");
	STAssertTrue([observer compareNotifyContext:self], @"should be equal");
}

-(void)observerTestMethod:(id<INotification>)notification {
	observerTestVar = [notification getBody];
}

@end
