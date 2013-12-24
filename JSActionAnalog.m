//
//  JSActionAnalog.m
//  Enjoy
//
//  Created by Sam McCall on 5/05/09.
//

@implementation JSActionAnalog

- (id) initWithIndex: (int)newIndex {
	if(self = [super init]) {
	subActions = [NSArray arrayWithObjects:
		[[SubAction alloc] initWithIndex: 0 name: @"Low" base: self],
		[[SubAction alloc] initWithIndex: 1 name: @"High" base: self],
        [[SubAction alloc] initWithIndex: 2 name: @"Analog" base: self],
		nil
	];
		[subActions retain];
	index = newIndex;
	name = [[NSString alloc] initWithFormat: @"Axis %d", (index+1)];
   }
	return self;
}

-(id) findSubActionForValue: (IOHIDValueRef) value {
    return [self findSubActionForValue:value acceptAnalog:NO];
}

-(id)findSubActionForValue: (IOHIDValueRef) value acceptAnalog:(BOOL)acceptAnalogEnabled {
    if (acceptAnalogEnabled && [[subActions objectAtIndex: 2] active]) {
        return [subActions objectAtIndex: 2]; // TODO?
    }
    
    //Target* target = [[base->configsController currentConfig] getTargetForAction: [subActions objectAtIndex: 0]];
    
	int raw = IOHIDValueGetIntegerValue(value);
    double parsed = [self getRealValue: raw];
	
	if(parsed < -0.3) // fixed?!
		return [subActions objectAtIndex: 0];
	else if(parsed > 0.3)
		return [subActions objectAtIndex: 1];
	return NULL;
}

-(void) notifyEvent: (IOHIDValueRef) value {
    // Analog action is always active
    [[subActions objectAtIndex: 2] setActive: true];
    
	int raw = IOHIDValueGetIntegerValue(value);
    double parsed = [self getRealValue: raw];
	
	[[subActions objectAtIndex: 0] setActive: (parsed < -0.3)];
	[[subActions objectAtIndex: 1] setActive: (parsed > 0.3)];
}

-(double) getRealValue: (int)value {
	double parsed = offset + scale * value;
    return parsed;
}

@synthesize offset, scale;


@end
