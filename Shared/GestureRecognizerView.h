//
//  RecognizerView.h
//

#import "OneDollarRecognizer.h"


@protocol GestureRecognizerViewDelegate;


@interface GestureRecognizerView : UIView {
    OneDollarRecognizer *_recognizer;

    UIImageView *_drawImage;
	CGPoint _lastPoint;

    NSMutableArray *_currentPath;

    id<GestureRecognizerViewDelegate> _delegate;
}

@property(retain) id<GestureRecognizerViewDelegate> delegate;

@end


@protocol GestureRecognizerViewDelegate <NSObject>

- (void) gestureRecognized: (NSDictionary *)recognitionResult;

@end