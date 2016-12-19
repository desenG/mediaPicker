//
//  Navigator.h
//  SmartRock2™
//
//  Created by DesenGuo on 2016-08-31.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import <Foundation/Foundation.h>
#define APPDELEGATE     ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define STORYBOARD_NAME   @"Main"
@interface Navigator : NSObject
#pragma mark get view
+(UIViewController *)getCurrentTopViewController;
+ (UIViewController *)getParentOfViewController:(UIViewController*)viewController;
#pragma mark open view
+(void)openViewControllerAsNewRootFromViewController:(UIViewController*)viewController
                                          withIDName:(NSString*)VCIDname;

+(void)pushViewControllerFromCurrentViewController:(UIViewController*)currentViewController
                          withAnotherViewController:(UIViewController*)anotherVC
                                       andAnimated:(BOOL)Animated;
#pragma mark back
+(void) returnFromViewController:(UIViewController*)viewController;
@end
