//
//  InteractionManager.h
//  SmartConcrete
//
//  Created by giatec on 2016-10-12.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InteractionManager : NSObject
+(void)addTappingDoneToView:(nullable UIView*)view
   withNumberOfTapsRequired:(int)numberOfTapsRequired
                  andAction:(nullable SEL)action
                   onTarget:(nullable id)target;
@end
