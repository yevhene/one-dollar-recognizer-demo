//
//  Globals.m
//  one-dollar-recognizer-demo
//

#import "Globals.h"


@implementation Globals

@synthesize templates = _templates;

+ (Globals *)instance {
    static Globals *instance = nil;
    if (!instance) {
        instance = [[Globals alloc] init];
    }
    
    return instance;
}

- (void) dealloc {
    [_templates release];
    
    [super dealloc];
}

@end
