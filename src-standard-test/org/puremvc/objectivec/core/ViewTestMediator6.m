//
//  ViewTestMediator6.m

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ViewTestMediator6.h"
#import "Facade.h"
#import	"ViewTest.h"

@implementation ViewTestMediator6

-(void)handleNotification:(id<INotification>)notification {
	[[Facade getInstance] removeMediator:[self getMediatorName]];
}

-(NSArray *)listNotificationInterests {
	return [NSArray arrayWithObject:@"Notification6"];
}

-(void)onRemove {
	((ViewTest *)viewComponent).counter++;
}

@end
