//
//  JSActionAnalog.h
//  Enjoy
//
//  Created by Sam McCall on 5/05/09.
//  Copyright 2009 University of Otago. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class JSAction;

#define ANALOG_LOW -0.3
#define ANALOG_HIGH 0.3

@interface JSActionAnalog : JSAction {
	double offset, scale;
}

@property(readwrite) double offset;
@property(readwrite) double scale;

- (id) initWithIndex: (int)newIndex;
-(double) getRealValue: (int) value;
-(id)findSubActionForValue: (IOHIDValueRef) value acceptAnalog:(BOOL)acceptAnalogEnabled;


@end
