//
//  UIImageView+Modify.m
//  mediaPicker
//
//  Created by giatec on 2016-12-20.
//  Copyright © 2016 com.giatec. All rights reserved.
//

#import "UIImageView+Modify.h"

@implementation UIImageView(Modify)
- (void)centerToUIView:(UIView *)contentView
{
    CGSize imageSize = self.image.size;
    [self sizeThatFits:imageSize];
    CGPoint imageViewCenter = self.center;
    imageViewCenter.x = CGRectGetMidX(contentView.frame);
    [self setCenter:imageViewCenter];
}

@end
