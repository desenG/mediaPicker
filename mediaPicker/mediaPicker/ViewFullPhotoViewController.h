//
//  ViewFullPhotoViewController.h
//  SmartRock2™
//
//  Created by MINGOU WU on 2016-12-15.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFullPhotoViewController : UIViewController {
    IBOutlet UIImageView *imgViewPhoto;
}
@property (strong, nonatomic) NSData* imageData;
@property (assign) id<MediaPickerViewControllerDelegate> delegate;
@end
