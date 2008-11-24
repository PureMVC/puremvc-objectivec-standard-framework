//
//  PureMVCAppDelegate.m
//  PureMVC
//
//  Created by Brian Knorr on 11/19/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "PureMVCAppDelegate.h"

@implementation PureMVCAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
