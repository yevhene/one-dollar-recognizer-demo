//
//  Globals.m
//  one-dollar-recognizer-demo
//

#import "Globals.h"


@interface Globals (private)

- (void) loadTemplateWithPath: (NSString *)path;

- (NSString *)templateNameFromPath: (NSString *)path;

@end


@implementation Globals

@synthesize templates = _templates;

- (id) init {
    if (self = [super init]) {
        // blank
    }
    return self;
}

- (void) dealloc {
    [_templates release];

    [super dealloc];
}

+ (Globals *)instance {
    static Globals *instance = nil;
    if (!instance) {
        instance = [[Globals alloc] init];
    }

    return instance;
}

- (void) loadTemplates {
    _templates = [NSMutableDictionary new];

    NSArray *templatesPaths =
    [[NSBundle mainBundle] pathsForResourcesOfType: @"template"
                                       inDirectory: nil];

    for (NSString *path in templatesPaths) {
        [self loadTemplateWithPath: path];
    }
}

- (void) loadTemplateWithPath: (NSString *)path {
    NSString *fileString =
    [NSString stringWithContentsOfFile: path
                              encoding: NSUTF8StringEncoding
                                 error: nil
     ];

    NSArray *stringValues =
    [fileString componentsSeparatedByCharactersInSet:
     [[NSCharacterSet decimalDigitCharacterSet] invertedSet]];

    NSMutableArray *points = [NSMutableArray array];

    double firstValue = 0;
    BOOL isFirstValue = YES;
    for (NSString *stringValue in stringValues) {
        double doubleValue = [stringValue doubleValue];
        if (isFirstValue) {
            firstValue = doubleValue;
            isFirstValue = NO;
        } else {
            CGPoint point = CGPointMake(firstValue, doubleValue);
            [points addObject: [NSValue valueWithCGPoint: point]];
            isFirstValue = YES;
        }
    }

    NSString *templateName = [self templateNameFromPath: path];

    [_templates setObject: points
                   forKey: templateName];

    NSLog(@"Template with name '%@' loaded. %d points.",
          templateName, [points count]);
}

- (NSString *)templateNameFromPath: (NSString *)path {
    NSArray *stringComponents = [path componentsSeparatedByString: @"/"];
    NSString *fileName = [stringComponents lastObject];
    NSString *templateName = [fileName stringByDeletingPathExtension];
    return templateName;
}


@end
