//
//  Mediator.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Mediator.h"

@implementation Mediator

@synthesize mediatorName, viewComponent;

+(id)mediator {
	return [[[self alloc] initWithMediatorName:nil viewComponent:nil] autorelease];
}

+(id)withMediatorName:(NSString *)mediatorName {
	return [[[self alloc] initWithMediatorName:mediatorName viewComponent:nil] autorelease];
}

+(id)withMediatorName:(NSString *)mediatorName viewComponent:(id)viewComponent {
	return [[[self alloc] initWithMediatorName:mediatorName viewComponent:viewComponent] autorelease];
}

+(id)withViewComponent:(id)viewComponent {
	return [[[self alloc] initWithMediatorName:nil viewComponent:viewComponent] autorelease];
}

-(id)initWithMediatorName:(NSString *)_mediatorName viewComponent:(id)_viewComponent {
	if (self = [super init]) {
		self.mediatorName = (_mediatorName == nil) ? [[self class] NAME] : _mediatorName;
		self.viewComponent = _viewComponent;
		[self initializeMediator];
	}
	return self;
}

/**
 * The name of the <code>Mediator</code>. 
 * 
 * <P>
 * Typically, a <code>Mediator</code> will be written to serve
 * one specific control or group controls and so,
 * will not have a need to be dynamically named.</P>
 */
+(NSString *)NAME {
	return @"Mediator";
}

/**
 * Initialize the Mediator instance.
 * 
 * <P>
 * Called automatically by the constructor, this
 * is your opportunity to initialize the Mediator
 * instance in your subclass without overriding the
 * constructor.</P>
 * 
 * @return void
 */
-(void)initializeMediator {}

/**
 * Handle <code>INotification</code>s.
 * 
 * <P>
 * Typically this will be handled in a switch statement,
 * with one 'case' entry per <code>INotification</code>
 * the <code>Mediator</code> is interested in.
 */
-(void)handleNotification:(id<INotification>)notification {}

/**
 * List the <code>INotification</code> names this
 * <code>Mediator</code> is interested in being notified of.
 * 
 * @return Array the list of <code>INotification</code> names 
 */
-(NSArray *)listNotificationInterests {
	return [NSArray array];
}

/**
 * Called by the View when the Mediator is registered
 */ 
-(void)onRegister {}

/**
 * Called by the View when the Mediator is removed
 */ 
-(void)onRemove {}

-(void)dealloc {
	self.mediatorName = nil;
	self.viewComponent = nil;
	[super dealloc];
}

@end
