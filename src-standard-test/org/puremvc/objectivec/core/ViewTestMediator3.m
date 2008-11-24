//
//  ViewTestMediator3.m

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ViewTestMediator3.h"
#import "ViewTest.h"

@implementation ViewTestMediator3

-(void)handleNotification:(id<INotification>)notification {
	[self.viewComponent setLastNotification:[notification getName]];
	((ViewTest *)viewComponent).counter++;
}

-(NSArray *)listNotificationInterests {
	return [NSArray arrayWithObject:@"Notification3"];
}

@end
