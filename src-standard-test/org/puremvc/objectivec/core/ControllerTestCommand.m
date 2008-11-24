//
//  ControllerTestCommand.m

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ControllerTestCommand.h"
#import "TestVO.h"

@implementation ControllerTestCommand

-(void)execute:(id<INotification>)notification {
	TestVO *vo = [notification getBody];
	vo.result = 2 * vo.input;
}

@end
