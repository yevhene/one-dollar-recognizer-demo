//
//  MainViewController.m
//  one-dollar-recognizer-demo
//

#import "MainViewController.h"


@implementation MainViewController

- (void) dealloc {
    [_resultsView release];

    [super dealloc];
}

- (void) loadView {
    [super loadView];

    self.view.backgroundColor = [UIColor whiteColor];

    CGRect gestureRecognizerViewFrame =
        CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
    GestureRecognizerView *gestureRecognizerView =
    [[[GestureRecognizerView alloc]
      initWithFrame: gestureRecognizerViewFrame]
     autorelease];
    gestureRecognizerView.delegate = self;

    [self.view addSubview: gestureRecognizerView];

    CGRect resultsViewFrame =
    CGRectMake(0, self.view.bounds.size.height / 2,
               self.view.bounds.size.width, self.view.bounds.size.height / 2);
    _resultsView = [[UITextView alloc] initWithFrame: resultsViewFrame];
    _resultsView.font = [UIFont fontWithName: @"Helvetica"
                                        size: 18];
    [self.view addSubview: _resultsView];
}

- (void) gestureRecognized: (NSDictionary *)recognitionResult {
    for (id key in [recognitionResult allKeys]) {
        NSString *result =
        [NSString stringWithFormat: @"%@->%f\n",
         key, [[recognitionResult objectForKey: key] doubleValue]];
        _resultsView.text = [_resultsView.text stringByAppendingString: result];
    }
    _resultsView.text =
    [_resultsView.text stringByAppendingString: @"------------------------------\n"];
}

@end
