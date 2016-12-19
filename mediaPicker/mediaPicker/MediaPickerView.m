//
//  MediaPickerView.m
//  CustomView
//
//  Created by Paul Solt on 4/28/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "MediaPickerView.h"

@interface MediaPickerView()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *viewAddPhoto;

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPrevew;


@end

@implementation MediaPickerView
{
    UIViewController* pHostViewController;
    NSData* imageData;
}
@synthesize viewAddPhoto,viewPreview,imgViewPrevew;

-(void)setHostViewController:(UIViewController*)hostViewController
{
    pHostViewController = hostViewController;
}
// Note: You can customize the behavior after calling the super method

// Called when loading programatically
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

// Called when loading from embedded .xib UIView
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (IBAction)actionAddPhoto:(id)sender {
    [[MediaPicker sharedInstance] showMenuFromViewController:pHostViewController withMenuTitle:@"Section Photo"andGetDataCompleteHandler:^(id obj, NSError *err) {
        if(err || !obj)
        {
            return;
        }
        
        viewAddPhoto.hidden = true;
        viewPreview.hidden = false;
        
        imageData = (NSData*)obj;
        UIImage *image = [UIImage imageWithData:imageData];
        if(!image)
        {
            return;
        }
        
        [imgViewPrevew setImage:image];
    }];
}
-(void)setup{
    [InteractionManager addTappingDoneToView:imgViewPrevew withNumberOfTapsRequired:1 andAction:@selector(handleTapGesture:) onTarget:self];

}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
        
        ViewFullPhotoViewController* viewFullPhotoViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewFullPhotoViewController"];
        viewFullPhotoViewController.imageData = imageData;
        [Navigator pushViewControllerFromCurrentViewController:pHostViewController withAnotherViewController:viewFullPhotoViewController andAnimated:YES];
    }
}


@end
