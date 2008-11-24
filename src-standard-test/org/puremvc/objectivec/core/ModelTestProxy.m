//
//  ModelTestProxy.m

//
//  Created by Brian Knorr on 11/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ModelTestProxy.h"


@implementation ModelTestProxy

-(void)onRegister {
	self.data = @"onRegister called";
}

-(void)onRemove {
	self.data = @"onRemove called";
}

@end
