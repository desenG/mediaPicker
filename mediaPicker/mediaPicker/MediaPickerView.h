//
//  MediaPickerView.h
//  CustomView
//
//  Created by Paul Solt on 4/28/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCustomViewFromXib.h"

@interface MediaPickerView : PSCustomViewFromXib
-(void)setHostViewController:(UIViewController*)hostViewController;
-(void)setImageDataInPickerView:(NSData*)imageData;
@end
