//
//  MediaPickerMenuView.h
//  SmartRock
//
//  Created by Hinal Shah on 2016-02-09.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MediaPickerMenuViewDelegate <NSObject>

-(void)actionTakePhoto;
-(void)actionChoosePhoto;
-(void)actionDelete;
-(void)actionHide;

@end

@interface MediaPickerMenuView : UIView
@property (assign) id<MediaPickerMenuViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIView *viewCamera;
@property (strong, nonatomic) IBOutlet UILabel *lblCameraroll;
@property (weak, nonatomic) IBOutlet UIButton *btnCameraroll;
@property (weak, nonatomic) IBOutlet UIImageView *imageCameraroll;

@property (strong, nonatomic) IBOutlet UILabel *lblCamera;
@property (strong, nonatomic) IBOutlet UIImageView *imgCamera;
@property (strong, nonatomic) IBOutlet UIButton *btnCamera;

@property (strong, nonatomic) IBOutlet UIImageView *imageDelete;
@property (strong, nonatomic) IBOutlet UILabel *lblDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;

@end
