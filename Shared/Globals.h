//
//  Globals.h
//  one-dollar-recognizer-demo
//


@interface Globals : NSObject {
    NSMutableDictionary *_templates;
}

@property(readonly) NSDictionary *templates;

- (void) loadTemplates;

+ (Globals *)instance;

@end
