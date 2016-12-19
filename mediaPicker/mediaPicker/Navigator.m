//
//  Navigator.m
//  SmartRock2™
//
//  Created by DesenGuo on 2016-08-31.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import "Navigator.h"

@implementation Navigator
#pragma mark get view
+(UIViewController *)getCurrentTopViewController
{
    UIViewController *parentViewController = [APPDELEGATE window].rootViewController;
    
    while (parentViewController.presentedViewController != nil){
        parentViewController = parentViewController.presentedViewController;
    }
    return parentViewController;
}
+ (UIViewController *)getParentOfViewController:(UIViewController*)viewController
{
    NSInteger myIndex = [viewController.navigationController.viewControllers indexOfObject:viewController];
    
    if ( myIndex != 0 && myIndex != NSNotFound ) {
        return [viewController.navigationController.viewControllers objectAtIndex:myIndex-1];
    } else {
        return nil;
    }
}
#pragma mark open view
+(void)openViewControllerAsNewRootFromViewController:(UIViewController*)viewController
                                          withIDName:(NSString*)VCIDname
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    
    [viewController.navigationController setViewControllers: [NSArray arrayWithObject: [storyboard instantiateViewControllerWithIdentifier:VCIDname ]]
                                                   animated: YES];
}

+(void)pushViewControllerFromCurrentViewController:(UIViewController*)currentViewController
                         withAnotherViewController:(UIViewController*)anotherVC
                                       andAnimated:(BOOL)Animated
{
    [currentViewController.navigationController pushViewController:anotherVC animated:Animated];
}
#pragma mark back
+(void) returnFromViewController:(UIViewController*)viewController
{
    [viewController.navigationController popViewControllerAnimated:YES];
}
@end
