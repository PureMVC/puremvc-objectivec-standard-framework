//
//  NotificationTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "NotificationTest.h"
#import "Notification.h"

@implementation NotificationTest

-(void)testConstructor {
	
	// Create a new Notification and use accessors to set the note name 
	id<INotification> note = [[[Notification alloc] initWithName:@"TestNote" body:@"5" type:@"TestType"] autorelease];
	
	// test assertions
	STAssertTrue([[note getName] isEqualToString:@"TestNote"], @"getName should be TestNote");
	STAssertTrue([[note getBody] isEqualToString:@"5"], @"getBody should be 5");
	STAssertTrue([[note getType] isEqualToString:@"TestType"], @"getType should be TestType");
}

@end
