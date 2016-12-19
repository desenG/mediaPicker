//
//  InteractionManager.m
//  SmartConcrete
//
//  Created by giatec on 2016-10-12.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import "InteractionManager.h"

@implementation InteractionManager
+(void)addTappingDoneToView:(nullable UIView*)view
   withNumberOfTapsRequired:(int)numberOfTapsRequired
                  andAction:(nullable SEL)action
                   onTarget:(nullable id)target
{
    if(!view) return;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGesture.numberOfTapsRequired = numberOfTapsRequired;
    [view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:tapGesture];
}
@end
