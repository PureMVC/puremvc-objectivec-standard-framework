//
//  SimpleCommand.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "SimpleCommand.h"


@implementation SimpleCommand

/**
 * Static Convenience Constructor. 
 */
+(id)command {
	return [[[self alloc] init] autorelease];
}

/**
 * Fulfill the use-case initiated by the given <code>INotification</code>.
 * 
 * <P>
 * In the Command Pattern, an application use-case typically
 * begins with some user action, which results in an <code>INotification</code> being broadcast, which 
 * is handled by business logic in the <code>execute</code> method of an
 * <code>ICommand</code>.</P>
 * 
 * @param notification the <code>INotification</code> to handle.
 */
-(void)execute:(id<INotification>)notification {}

@end
