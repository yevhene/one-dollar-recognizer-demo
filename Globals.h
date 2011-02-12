//
//  Globals.h
//  one-dollar-recognizer-demo
//


@interface Globals : NSObject {
    NSDictionary *_templates;
}

@property(readonly) NSDictionary *templates;

+ (Globals *)instance;

@end
