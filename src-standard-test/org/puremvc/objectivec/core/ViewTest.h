//
//  ViewTest.h

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
#import "GTMSenTestCase.h"

@interface ViewTest : SenTestCase {
	NSString *viewTestVar, *lastNotification;
	BOOL onRegisterCalled, onRemoveCalled;
	int counter;
}

@property BOOL onRegisterCalled, onRemoveCalled;
@property(nonatomic, retain) NSString *lastNotification;
@property int counter;

@end
