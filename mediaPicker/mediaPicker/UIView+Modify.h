//
//  UIView+Modify.h
//  mediaPicker
//
//  Created by giatec on 2016-12-20.
//  Copyright © 2016 com.giatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Modify)
- (void)centerToUIView:(UIView *)contentView;
- (void)centerToParentView;
-(void)resizeWithNewHeight:(CGFloat)newHeight;
@end
