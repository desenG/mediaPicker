//
//  ViewController.m
//  mediaPicker
//
//  Created by giatec on 2016-12-19.
//  Copyright © 2016 com.giatec. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mpv_photo;
- (void)viewDidLoad {
    [super viewDidLoad];
    [mpv_photo setHostViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setImageData:(NSData*)imageData
{
    [mpv_photo setImageDataInPickerView:imageData];
}
@end
