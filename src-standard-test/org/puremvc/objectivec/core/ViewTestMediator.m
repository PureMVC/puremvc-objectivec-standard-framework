//
//  ViewTestMediator.m

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ViewTestMediator.h"

@implementation ViewTestMediator

-(void)onRegister {
	[self.viewComponent setOnRegisterCalled:YES];
}

-(void)onRemove {
	[self.viewComponent setOnRemoveCalled:YES];
}

-(void)handleNotification:(id<INotification>)notification {
	[self.viewComponent setLastNotification:[notification getName]];
}

-(NSArray *)listNotificationInterests {
	return [NSArray arrayWithObjects:@"Notification1", @"Notification2", nil];
}

@end
