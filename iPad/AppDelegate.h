//
//  AppDelegate_iPad.h
//  one-dollar-recognizer-demo
//

#import "MainViewController.h"


@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *_window;

    MainViewController *_mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

