//
//  MainViewController.h
//  one-dollar-recognizer-demo
//

#import "GestureRecognizerView.h"

@interface MainViewController : UIViewController <GestureRecognizerViewDelegate> {
    UITextView *_resultsView;
}

@end
