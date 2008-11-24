//
//  ControllerTest.m

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ControllerTest.h"
#import "Controller.h"
#import "ControllerTestCommand.h"
#import "ControllerTestCommand2.h"
#import "TestVO.h"
#import "Notification.h"
#import "View.h"

@implementation ControllerTest

-(void)testGetInstance {
	id<IController> controller = [Controller getInstance];
	STAssertTrue(controller != nil, @"controller should not be nil");
}

-(void)testRegisterAndExecuteCommand {
	// Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
	id<IController> controller = [Controller getInstance];
	[controller registerCommand:@"ControllerTest" commandClassRef:[ControllerTestCommand class]];
	
	// Create a 'ControllerTest' note
    TestVO *vo = [[[TestVO alloc] init] autorelease];
	vo.input = 12;
	Notification *note = [[[Notification alloc] initWithName:@"ControllerTest" body:vo type:nil] autorelease];

	// Tell the controller to execute the Command associated with the note
	// the ControllerTestCommand invoked will multiply the vo.input value
	// by 2 and set the result on vo.result
	[controller executeCommand:note];

	STAssertTrue(vo.result == 24, @"Expecting vo.result == 24");
}

-(void)testRegisterAndRemoveCommand {
	
	// Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
	id<IController> controller = [Controller getInstance];
	[controller registerCommand:@"ControllerRemoveTest" commandClassRef:[ControllerTestCommand class]];
	
	// Create a 'ControllerTest' note
	TestVO *vo = [[[TestVO alloc] init] autorelease];
	vo.input = 12;
	Notification *note = [[[Notification alloc] initWithName:@"ControllerRemoveTest" body:vo type:nil] autorelease];
	
	// Tell the controller to execute the Command associated with the note
	// the ControllerTestCommand invoked will multiply the vo.input value
	// by 2 and set the result on vo.result
	[controller executeCommand:note];
	
	// test assertions 
	STAssertTrue(vo.result == 24, @"Expecting vo.result == 24");
	
	// Reset result
	vo.result = 0;
	
	// Remove the Command from the Controller
	[controller removeCommand:@"ControllerRemoveTest"];
	
	// Tell the controller to execute the Command associated with the
	// note. This time, it should not be registered, and our vo result
	// will not change               
	[controller executeCommand:note];
	
	// test assertions 
	STAssertTrue(vo.result == 0, @"Expecting vo.result == 0");
}

-(void)testHasCommand {
	
	// register the ControllerTestCommand to handle 'hasCommandTest' notes
	id<IController> controller = [Controller getInstance];
	[controller registerCommand:@"hasCommandTest" commandClassRef:[ControllerTestCommand class]];
	
	// test that hasCommand returns true for hasCommandTest notifications 
	STAssertTrue([controller hasCommand:@"hasCommandTest"], @"[controller hasCommand:@\"hasCommandTest\"] == YES");
	
	// Remove the Command from the Controller
	[controller removeCommand:@"hasCommandTest"];
	
	// test that hasCommand returns false for hasCommandTest notifications 
	STAssertFalse([controller hasCommand:@"hasCommandTest"], @"[controller hasCommand:@\"hasCommandTest\"] == NO");
}

-(void)testReregisterAndExecuteCommand {
	
	// Fetch the controller, register the ControllerTestCommand2 to handle 'ControllerTest2' notes
	id<IController> controller = [Controller getInstance];
	[controller registerCommand:@"ControllerTest2" commandClassRef:[ControllerTestCommand2 class]];
	
	// Remove the Command from the Controller
	[controller removeCommand:@"ControllerTest2"];
	
	// Re-register the Command with the Controller
	[controller registerCommand:@"ControllerTest2" commandClassRef:[ControllerTestCommand2 class]];
	
	// Create a 'ControllerTest2' note
	TestVO *vo = [[[TestVO alloc] init] autorelease];
	vo.input = 12;
	Notification *note = [[[Notification alloc] initWithName:@"ControllerTest2" body:vo type:nil] autorelease];
	
	// retrieve a reference to the View.
	id<IView> view = [View getInstance];
	
	// send the Notification
	[view notifyObservers:note];
	
	// test assertions 
	// if the command is executed once the value will be 24
	STAssertTrue(vo.result == 24, @"Expecting vo.result == 24");
	
	// Prove that accumulation works in the VO by sending the notification again
	[view notifyObservers:note];
	
	// if the command is executed twice the value will be 48
	STAssertTrue(vo.result == 48, @"Expecting vo.result == 48");
}

@end
