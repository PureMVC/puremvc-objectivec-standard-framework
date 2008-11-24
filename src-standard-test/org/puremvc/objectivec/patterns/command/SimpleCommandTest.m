//
//  SimpleCommandTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "SimpleCommandTest.h"
#import "TestVO.h"
#import "Notification.h"
#import "TestCommand.h"

@implementation SimpleCommandTest

-(void)testSimpleCommandExecute {
	
	// Create the VO
	TestVO *vo = [[[TestVO alloc] init] autorelease];
	vo.input = 5;
	
	// Create the Notification (note)
	id<INotification> note = [[[Notification alloc] initWithName:@"SimpleCommandTest" body:vo type:nil] autorelease];
	
	// Create the SimpleCommand              
	id<ICommand> command = [[[TestCommand alloc] init] autorelease];
	
	[command execute:note];
	
	// test assertions
	STAssertTrue(vo.result == 10, @"result should be 10");
	
}


@end
