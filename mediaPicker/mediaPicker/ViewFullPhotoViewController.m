//
//  ViewFullPhotoViewController.m
//  SmartRock2™
//
//  Created by MINGOU WU on 2016-12-15.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import "ViewFullPhotoViewController.h"

@interface ViewFullPhotoViewController ()

@end

@implementation ViewFullPhotoViewController
@synthesize imageData;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self loadImage];
}

-(void)loadImage
{
    if(!imageData)
    {
        return;
    }
    UIImage *image = [UIImage imageWithData:imageData];
    if(!image)
    {
        return;
    }
    [imgViewPhoto setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBack:(id)sender {
    [self.delegate setImageData:imageData.copy];
    [self.navigationController popViewControllerAnimated:YES];
    imageData = nil;
}

- (IBAction)actionShowMenu:(id)sender {
    [[MediaPicker sharedInstance] showMenuFromViewController:self withMenuTitle:@"Section Photo"andGetDataCompleteHandler:^(id obj, NSError *err) {
        if(err)
        {
            return;
        }
        
        imageData = (!obj)?nil:(NSData*)obj;

        UIImage *image = [UIImage imageWithData:imageData];
        
        [imgViewPhoto setImage:image];
    }];
}

@end
