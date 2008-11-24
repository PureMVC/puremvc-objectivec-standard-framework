//
//  ViewTest.m

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ViewTest.h"
#import "View.h"
#import "Observer.h"
#import "Notification.h"
#import "Mediator.h"
#import "ViewTestMediator.h"
#import "ViewTestMediator3.h"
#import "ViewTestMediator6.h"

@implementation ViewTest

@synthesize onRegisterCalled, onRemoveCalled, lastNotification, counter;

-(void)testGetInstance {
	id<IView> view = [View getInstance];
	STAssertTrue(view != nil, @"view should not be nil");
}

-(void)viewTestMethod:(id<INotification>)notification {
	// set the local viewTestVar to the number on the event payload
	viewTestVar = [notification getBody];
}


-(void)testRegisterAndNotifyObserver {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create observer, passing in notification method and context
	id<IObserver> observer = [[[Observer alloc] initWithNotifyMethod:@selector(viewTestMethod:) notifyContext:self] autorelease];
	
	// Register Observer's interest in a particulat Notification with the View 
	[view registerObserver:@"ViewTestNote" observer:observer];
	
	// Create a ViewTestNote, setting 
	// a body value, and tell the View to notify 
	// Observers. Since the Observer is this class 
	// and the notification method is viewTestMethod,
	// successful notification will result in our local 
	// viewTestVar being set to the value we pass in 
	// on the note body.
	id<INotification> note = [[[Notification alloc] initWithName:@"ViewTestNote" body:@"10" type:nil] autorelease];
	[view notifyObservers:note];
	
	// test assertions 
	STAssertTrue([viewTestVar isEqualToString:@"10"], @"viewTestVar should be 10");
}

-(void)testRegisterAndRetrieveMediator {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> viewTestMediator = [[[Mediator alloc] initWithMediatorName:@"ViewTestMediator" viewComponent:self] autorelease];
	[view registerMediator:viewTestMediator];
	
	// Retrieve the component
	id<IMediator> mediator = [view retrieveMediator:@"ViewTestMediator"];
	
	// test assertions              
	STAssertTrue([mediator isEqualTo:viewTestMediator], "should be the same mediator");
}

-(void)testHasMediator {
	
	// register a Mediator
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> mediator = [[[Mediator alloc] initWithMediatorName:@"hasMediatorTest" viewComponent:self] autorelease];
	[view registerMediator:mediator];
	
	// assert that the view.hasMediator method returns true
	// for that mediator name
	STAssertTrue([view hasMediator:@"hasMediatorTest"], @"view should have mediator");
	
	[view removeMediator:@"hasMediatorTest"];
	
	// assert that the view.hasMediator method returns false
	// for that mediator name
	STAssertFalse([view hasMediator:@"hasMediatorTest"], @"view should not have mediator");
}

-(void)testRegisterAndRemoveMediator {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> mediator = [[[Mediator alloc] initWithMediatorName:@"testing" viewComponent:self] autorelease];
	[view registerMediator:mediator];
	
	// Remove the component
	id<IMediator> removeMediator = [view removeMediator:@"testing"];
	
	// assert that we have removed the appropriate mediator
	STAssertTrue([[removeMediator getMediatorName] isEqualToString:@"testing"], @"name should be testing");
	
	// assert that the mediator is no longer retrievable
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"retrieve mediator should be nil");
}

-(void)testOnRegisterAndOnRemove {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> mediator = [[[ViewTestMediator alloc] initWithMediatorName:@"testing" viewComponent:self] autorelease];
	[view registerMediator:mediator];
	
	// assert that onRegsiter was called, and the mediator responded by setting our boolean
	STAssertTrue(onRegisterCalled, @"onRegisterCalled should be YES");
	
	// Remove the component
	[view removeMediator:@"testing"];
	
	// assert that the mediator is no longer retrievable
	STAssertTrue(onRemoveCalled, @"onRemoveCalled should be YES");
}

-(void)testSuccessiveRegisterAndRemoveMediator {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator, 
	// but not so we have a reference to it
	id<IMediator> mediator = [[[ViewTestMediator alloc] initWithMediatorName:@"testing" viewComponent:self] autorelease];
	[view registerMediator:mediator];
	
	// test that we can retrieve it
	STAssertTrue([view retrieveMediator:@"testing"] != nil, @"mediator should not be nil");
	
	// Remove the Mediator
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");
	
	// test that removing the mediator again once its gone doesn't cause crash         
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should again be nil");
	
	//register again instance of the test mediator, 
	[view registerMediator:mediator];
	
	STAssertTrue([view retrieveMediator:@"testing"] != nil, @"mediator should not be nil");
	
	// Remove the Mediator
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");                                     
}

-(void)testRemoveMediatorAndSubsequentNotify {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator to be removed.
	id<IMediator> mediator = [[[ViewTestMediator alloc] initWithMediatorName:@"testing" viewComponent:self] autorelease];
	[view registerMediator:mediator];
	
	// test that notifications work
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification1" body:nil type:nil] autorelease]];
	STAssertTrue([lastNotification isEqualToString:@"Notification1"], @"should be equal to Notification1");
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification2" body:nil type:nil] autorelease]];
	STAssertTrue([lastNotification isEqualToString:@"Notification2"], @"should be equal to Notification2");
	
	// Remove the Mediator
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");
	
	// test that notifications no longer work
	// (ViewTestMediator2 is the one that sets lastNotification
	// on this component, and ViewTestMediator)
	self.lastNotification = nil;
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification1" body:nil type:nil] autorelease]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification2" body:nil type:nil] autorelease]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");                                     
}

-(void)testRemoveOneOfTwoMediatorsAndSubsequentNotify {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register that responds to notifications 1 and 2
	id<IMediator> mediator = [[[ViewTestMediator alloc] initWithMediatorName:@"testing" viewComponent:self] autorelease];
	[view registerMediator:mediator];
	
	// Create and register that responds to notification 3
	id<IMediator> mediator3 = [[[ViewTestMediator3 alloc] initWithMediatorName:@"testing3" viewComponent:self] autorelease];
	[view registerMediator:mediator3];
	
	// test that all notifications work
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification1" body:nil type:nil] autorelease]];
	STAssertTrue([lastNotification isEqualToString:@"Notification1"], @"should be equal to Notification1");
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification2" body:nil type:nil] autorelease]];
	STAssertTrue([lastNotification isEqualToString:@"Notification2"], @"should be equal to Notification2");
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification3" body:nil type:nil] autorelease]];
	STAssertTrue([lastNotification isEqualToString:@"Notification3"], @"should be equal to Notification3");
	
	// Remove the Mediator that responds to 1 and 2
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");
	
	// test that notifications no longer work
	// for notifications 1 and 2, but still work for 3
	self.lastNotification = nil;
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification1" body:nil type:nil] autorelease]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification2" body:nil type:nil] autorelease]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");  
	
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification3" body:nil type:nil] autorelease]];
	STAssertTrue([lastNotification isEqualToString:@"Notification3"], @"should be equal to Notification3");                                     
}

-(void)testMediatorReregistration {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register that responds to notification 3
	id<IMediator> mediator3 = [[[ViewTestMediator3 alloc] initWithMediatorName:@"testing3" viewComponent:self] autorelease];
	[view registerMediator:mediator3];

	
	// try to register another.
	[view registerMediator:mediator3];
	
	// test that the counter is only incremented once (mediator 3's response) 
	counter = 0;
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification3" body:nil type:nil] autorelease]];
	STAssertTrue(counter == 1, @"counter should be 1");
	
	// Remove the Mediator 
	[view removeMediator:@"testing3"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing3"] == nil, @"mediator should be nil");
	
	// test that the counter is no longer incremented  
	counter = 0;
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification3" body:nil type:nil] autorelease]];
	STAssertTrue(counter == 0, @"counter should be 0");
}

-(void)testModifyObserverListDuringNotification {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register several mediator instances that respond to notification 6 
	// by removing themselves, which will cause the observer list for that notification 
	// to change. versions prior to Standard Version 2.0.4 will see every other mediator
	// fails to be notified.  
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing1" viewComponent:self] autorelease]];
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing2" viewComponent:self] autorelease]];
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing3" viewComponent:self] autorelease]];
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing4" viewComponent:self] autorelease]];
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing5" viewComponent:self] autorelease]];
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing6" viewComponent:self] autorelease]];
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing7" viewComponent:self] autorelease]];
	[view registerMediator:[[[ViewTestMediator6 alloc] initWithMediatorName:@"testing8" viewComponent:self] autorelease]];
	
	// clear the counter
	counter = 0;
	// send the notification. each of the above mediators will respond by removing
	// themselves and incrementing the counter by 1. This should leave us with a
	// count of 8, since 8 mediators will respond.
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification6" body:nil type:nil] autorelease]];
	// verify the count is correct
	STAssertTrue(counter == 8, @"counter should be 8");
    
	// test that the counter is no longer incremented
	counter = 0;
	[view notifyObservers:[[[Notification alloc] initWithName:@"Notification6" body:nil type:nil] autorelease]];
	STAssertTrue(counter == 0, @"counter should be 0");
}

@end
