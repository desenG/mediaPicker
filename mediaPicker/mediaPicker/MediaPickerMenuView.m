//
//  MediaPickerMenuView.m
//  SmartRock
//
//  Created by Hinal Shah on 2016-02-09.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import "MediaPickerMenuView.h"

@implementation MediaPickerMenuView

- (IBAction)takePhoto:(id)sender
{
    [self.delegate actionTakePhoto];
}
- (IBAction)choosePhoto:(id)sender
{
    [self.delegate actionChoosePhoto];
}
- (IBAction)Delete:(id)sender
{
    [self.delegate actionDelete];
}
-(IBAction)Hide:(id)sender
{
    [self.delegate actionHide];
}
@end
