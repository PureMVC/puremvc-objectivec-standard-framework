//
//  Notification.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interfaces.h"

@interface Notification : NSObject <INotification> {
	NSString *name, *type;
	id body;
}

@property(nonatomic, retain, getter=getName) NSString *name;
@property(nonatomic, retain, getter=getType) NSString *type;
@property(nonatomic, retain, getter=getBody) id body;

+(id)withName:(NSString *)nam;
+(id)withName:(NSString *)name body:(id)body;
+(id)withName:(NSString *)name body:(id)body type:(NSString *)type;
+(id)withName:(NSString *)name type:(NSString *)type;
-(id)initWithName:(NSString *)name body:(id)body type:(NSString *)type;

@end
