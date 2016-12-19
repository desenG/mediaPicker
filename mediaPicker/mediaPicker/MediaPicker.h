//
//  MediaPicker.h
//  FacebookHelper
//
//  Created by DesenGuo on 2016-03-08.
//
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "JGActionSheet.h"

#ifndef MediaPicker_h
#define MediaPicker_h


#endif /* MediaPicker_h */

@protocol MediaPickerViewControllerDelegate <NSObject>

-(void)setImageData:(NSData*)imageData;

@end

@interface MediaPicker : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate,MPMediaPickerControllerDelegate,MediaPickerMenuViewDelegate>
{
    
}
+(MediaPicker*)sharedInstance;

@property(nonatomic,retain)AVAsset* pickedAsset;
@property(nonatomic,retain)NSURL * pickedAssetURL;
@property(nonatomic,retain)UIImage *  pickedImage;
@property(nonatomic,retain)UIViewController* m_controller;
@property (nonatomic,copy)GetDataCompletitionBlock completitionBlock;
-(void)showDialogFromViewController:(UIViewController*)viewController
         withGetDataCompleteHandler:(GetDataCompletitionBlock)completeHandler;
-(void)showMenuFromViewController:(UIViewController*)viewController
                    withMenuTitle:(NSString*)menuTitle
        andGetDataCompleteHandler:(GetDataCompletitionBlock)completeHandler;
-(void)loadAssetFromViewController:(UIViewController*) p_viewcontroller
WithAssetType: (NSString*)assetType// movie-kUTTypeMovie image-kUTTypeImage
andUIImagePickerControllerSourceType: (NSInteger)resourceType// UIImagePickerControllerSourceTypeCamera/UIImagePickerControllerSourceTypeSavedPhotosAlbum
       andGetDataCompletitionBlock:(GetDataCompletitionBlock) loadDataCompletitionBlock;
@end
