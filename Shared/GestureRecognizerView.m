//
//  RecognizerView.m
//

#import "GestureRecognizerView.h"

#import "Globals.h"


@implementation GestureRecognizerView

@synthesize delegate = _delegate;

- (void) dealloc {
    [_recognizer release];
    [_currentPath release];
    [_drawImage release];
    [_delegate release];

    [super dealloc];
}

- (void) layoutSubviews {
    [super layoutSubviews];

    self.backgroundColor = [UIColor grayColor];

    _recognizer =
    [[OneDollarRecognizer alloc] initWithTemplates: [Globals instance].templates
                                         andRegion: self.bounds];

    _currentPath = [NSMutableArray new];

    _drawImage = [[UIImageView alloc] initWithImage: nil];
	_drawImage.frame = self.bounds;
	[self addSubview: _drawImage];
}

- (void)touchesBegan: (NSSet *)touches
           withEvent: (UIEvent *)event {
    _drawImage.image = nil;

	_lastPoint = [[touches anyObject] locationInView: self];

    [_currentPath release];
    _currentPath = [NSMutableArray new];

    [_currentPath addObject: [NSValue valueWithCGPoint: _lastPoint]];
}

- (void)touchesMoved: (NSSet *)touches
           withEvent: (UIEvent *)event {
	CGPoint currentPoint = [[touches anyObject] locationInView: self];

    [_currentPath addObject: [NSValue valueWithCGPoint: currentPoint]];

	UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	[_drawImage.image drawInRect:
     CGRectMake(0, 0, _drawImage.frame.size.width, _drawImage.frame.size.height)];
	CGContextSetLineWidth(context, 10.0);
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, _lastPoint.x, _lastPoint.y);
	CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
	CGContextStrokePath(context);
	_drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	_lastPoint = currentPoint;
}

- (void)touchesEnded: (NSSet *)touches
           withEvent: (UIEvent *)event {
    NSLog(@"Recognition. Path length: %d", [_currentPath count]);
    NSDictionary *recognitionResult = [_recognizer recognize: _currentPath];
    NSLog(@"Recognized. Results: %d", [recognitionResult count]);
    if (self.delegate) {
        [self.delegate gestureRecognized: recognitionResult];
    }
}

@end
