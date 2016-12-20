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
    UIViewController<MediaPickerViewControllerDelegate>* mHostViewController;
    NSData* imageData;
}
@synthesize viewAddPhoto,viewPreview,imgViewPrevew;

-(void)setHostViewController:(UIViewController<MediaPickerViewControllerDelegate>*)hostViewController
{
    mHostViewController = hostViewController;
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
    [[MediaPicker sharedInstance] showMenuFromViewController:mHostViewController withMenuTitle:@"Section Photo"andGetDataCompleteHandler:^(id obj, NSError *err) {
        if(err)
        {
            return;
        }
        
        imageData = (!obj)?nil:(NSData*)obj;
        [self showImage];
    }];
}

-(void)showImage
{
    viewAddPhoto.hidden = (imageData !=nil);
    viewPreview.hidden = (imageData ==nil);

    if(!imageData) return;
    
    [self resizeWithNewHeight:200];
    [viewPreview resizeWithNewHeight:200];
    [viewPreview centerToParentView];
    
    UIImage *image = [UIImage imageWithData:imageData];

    [imgViewPrevew setImage:image];
}

-(void)setup{
    [InteractionManager addTappingDoneToView:imgViewPrevew withNumberOfTapsRequired:1 andAction:@selector(handleTapGesture:) onTarget:self];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
        
        ViewFullPhotoViewController* viewFullPhotoViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewFullPhotoViewController"];
        viewFullPhotoViewController.imageData = imageData;
        viewFullPhotoViewController.delegate = mHostViewController;
        [Navigator pushViewControllerFromCurrentViewController:mHostViewController withAnotherViewController:viewFullPhotoViewController andAnimated:YES];
    }
}

-(void)setImageDataInPickerView:(NSData*)pImageData
{
    imageData = pImageData;
    [self showImage];
}

@end
