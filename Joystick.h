//
//  Joystick.h
//  Enjoy
//
//  Created by Sam McCall on 4/05/09.
//  Copyright 2009 University of Otago. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class JSAction;

@interface Joystick : NSObject {
	int vendorId;
	int productId;
	int index;
	NSString* productName;
	IOHIDDeviceRef device;
	NSMutableArray* children;
	NSString* name;
}

@property(readwrite) int vendorId;
@property(readwrite) int productId;
@property(readwrite) int index;
@property(readwrite, copy) NSString* productName;
@property(readwrite) IOHIDDeviceRef device;
@property(readonly) NSArray* children;
@property(readonly) NSString* name;

-(void) populateActions;
-(void) invalidate;
-(id) handlerForEvent: (IOHIDValueRef) value;
-(id) handlerForEvent: (IOHIDValueRef) value acceptAnalog:(BOOL)acceptAnalogEnabled;
-(id)initWithDevice: (IOHIDDeviceRef) newDevice;
-(JSAction*) actionForEvent: (IOHIDValueRef) value;

@end
