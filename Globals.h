//
//  Globals.h
//  one-dollar-recognizer-demo
//


@interface Globals : NSObject {
    NSMutableDictionary *_templates;
}

@property(readonly) NSDictionary *templates;

+ (Globals *)instance;

@end
