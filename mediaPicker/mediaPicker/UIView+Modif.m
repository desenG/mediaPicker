//
//  UIView+Modify.m
//  mediaPicker
//
//  Created by giatec on 2016-12-20.
//  Copyright © 2016 com.giatec. All rights reserved.
//

#import "UIView+Modify.h"

@implementation UIView(Modify)
- (void)centerToUIView:(UIView *)contentView
{
    self.center = CGPointMake(contentView.frame.size.width  / 2,
                                     contentView.frame.size.height / 2);
}

- (void)centerToParentView
{
    self.center = CGPointMake(self.superview.frame.size.width  / 2,
                              self.superview.frame.size.height / 2);
}

-(void)resizeWithNewHeight:(CGFloat)newHeight
{
    CGRect newFrame_self = self.frame;
    newFrame_self.size.height = newHeight;
    [self setFrame:newFrame_self];
}

@end
