//
//  MediatorTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "MediatorTest.h"
#import "Mediator.h"

@implementation MediatorTest

-(void)testNameAccessor {
	
	// Create a new Mediator and use accessors to set the mediator name 
	id<IMediator> mediator = [[[Mediator alloc] init] autorelease];
	
	// test assertions
	STAssertTrue([[mediator getMediatorName] isEqualToString:@"Mediator"], @"mediator name should be Mediator");
}

-(void)testViewAccessor {
	
	// Create a view object
	id object = [[[NSObject alloc] init] autorelease];
	
	// Create a new Proxy and use accessors to set the proxy name 
	id<IMediator> mediator = [[[Mediator alloc] initWithMediatorName:@"MyMediator" viewComponent:object] autorelease];
	
	// test assertions
	STAssertNotNULL([mediator getViewComponent], @"viewComponent should not be nil");
}


@end
