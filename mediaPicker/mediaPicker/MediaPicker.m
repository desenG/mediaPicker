//
//  MediaPicker.m
//  FacebookHelper
//
//  Created by DesenGuo on 2016-03-08.
//

#import <Foundation/Foundation.h>
#import "MediaPicker.h"
static MediaPicker *_sharedInstance;

@implementation MediaPicker
{
    JGActionSheet *addPotoMenuSheet;
    MediaPickerMenuView *addPotoMenu;
    GetDataCompletitionBlock mCompleteHandler;
    UIViewController* hostViewController;
}

@synthesize pickedAsset,m_controller,pickedAssetURL,pickedImage;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [MediaPicker new];
    });
    return _sharedInstance;
}

-(void)showMenuFromViewController:(UIViewController*)viewController
                    withMenuTitle:(NSString*)menuTitle
andGetDataCompleteHandler:(GetDataCompletitionBlock)completeHandler
{
    hostViewController = viewController;
    mCompleteHandler = completeHandler;
    addPotoMenu = [[[NSBundle mainBundle] loadNibNamed:@"MediaPickerMenuView" owner:self options:nil] objectAtIndex:0];
    addPotoMenu.frame = CGRectMake(0,
                                   0,
                                   [[UIScreen mainScreen] applicationFrame].size.width,
                                   [[UIScreen mainScreen] applicationFrame].size.height);
    addPotoMenu.lblTitle.text = menuTitle;
    addPotoMenu.delegate = self;
    [viewController.view addSubview:addPotoMenu];
}
-(void)showDialogFromViewController:(UIViewController*)viewController
                withGetDataCompleteHandler:(GetDataCompletitionBlock)completeHandler
{
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Take Photo", @"Use Existing"] buttonStyle:JGActionSheetButtonStyleDefault];
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Cancel"] buttonStyle:JGActionSheetButtonStyleCancel];
    
    NSArray *sections = @[section1, cancelSection];
    
    addPotoMenuSheet = [JGActionSheet actionSheetWithSections:sections];
    
    [addPotoMenuSheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        if(indexPath.section==1)
        {
            return;
        }
        switch(indexPath.row) {
                
                // Take Photo
            case 0:
            {
                [_sharedInstance loadAssetFromViewController:viewController WithAssetType:(NSString*)kUTTypeImage andUIImagePickerControllerSourceType:UIImagePickerControllerSourceTypeCamera andGetDataCompletitionBlock:^(id obj, NSError *err) {
                    if(err)
                    {
                        completeHandler(nil,err);
                        return;
                    }
                    UIImage* img=(UIImage*)obj;
                    if (img) {
                        NSData *pngImageData = UIImagePNGRepresentation(img);
                        
                        if(pngImageData) {
                            completeHandler(pngImageData,nil);
                        }
                        else{
                            completeHandler(nil,[NSError unexpectedError]);
                        }
                    }
                }];
                break;
            }
            case 1:
            {
                [_sharedInstance loadAssetFromViewController:viewController WithAssetType:(NSString*)kUTTypeImage andUIImagePickerControllerSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum andGetDataCompletitionBlock:^(id obj, NSError *err) {
                    if(err)
                    {
                        completeHandler(nil,err);
                        return;
                    }
                    UIImage* img=(UIImage*)obj;
                    if (img) {
                        NSData *pngImageData = UIImagePNGRepresentation(img);
                        
                        if(pngImageData) {
                            completeHandler(pngImageData,nil);
                        }
                        else{
                            completeHandler(nil,[NSError unexpectedError]);
                        }
                    }
                }];
                break;
            }
            default:
                break;
        }
    }];
    
    [addPotoMenuSheet showInView:viewController.view animated:YES];
}

-(void)loadAssetFromViewController:(UIViewController*) p_viewcontroller
WithAssetType: (NSString*)assetType// movie-kUTTypeMovie image-kUTTypeImage
andUIImagePickerControllerSourceType: (NSInteger)resourceType
  andGetDataCompletitionBlock:(GetDataCompletitionBlock) loadDataCompletitionBlock
{
    m_controller=p_viewcontroller;
    _completitionBlock=loadDataCompletitionBlock;
    [self startMediaBrowserFromViewController:m_controller usingDelegate:self assetType:assetType UIImagePickerControllerSourceType:resourceType];
}

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate
                                   assetType: (NSString*)assetType// movie-kUTTypeMovie image-kUTTypeImage
           UIImagePickerControllerSourceType: (NSInteger)resourceType
{
    
//    if([assetType isEqualToString:(NSString*)kUTTypeImage])
//    {
//        return [self startImageBrowserFromViewController:controller usingDelegate:delegate assetType:(NSString*)kUTTypeImage UIImagePickerControllerSourceType:resourceType];
//    }

    return [self startImageBrowserFromViewController:controller usingDelegate:delegate assetType:assetType UIImagePickerControllerSourceType:resourceType];;
}

- (BOOL) startImageBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate
                                   assetType: (NSString*)assetType// movie-kUTTypeMovie image-kUTTypeImage
           UIImagePickerControllerSourceType: (NSInteger)resourceType
{
    
    if ((delegate == nil)
        || (controller == nil))
        return NO;
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];

    if(resourceType==UIImagePickerControllerSourceTypeSavedPhotosAlbum && ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO))
        return NO;
    if(resourceType==UIImagePickerControllerSourceTypeCamera && ([UIImagePickerController isSourceTypeAvailable:
                                                                            UIImagePickerControllerSourceTypeCamera] == NO))
    {
        return NO;
    }
    
    mediaUI.sourceType = resourceType;
    
    if(resourceType==UIImagePickerControllerSourceTypeCamera)
    {
        mediaUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: assetType, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    
    mediaUI.delegate = delegate;
    
    [controller presentViewController: mediaUI animated: YES completion:nil];
    return YES;
}



// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [m_controller dismissViewControllerAnimated:NO completion:nil];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        NSLog(@"Captured is movie");
        pickedAssetURL=[info objectForKey:UIImagePickerControllerMediaURL];
        pickedAsset = [AVAsset assetWithURL:pickedAssetURL];
        if(_completitionBlock)
        {
            _completitionBlock(pickedAssetURL,nil);
        }
    }
    else if(CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeImage, 0)== kCFCompareEqualTo)
    {
        NSLog(@"Captured is image");
        pickedAssetURL=[info objectForKey:UIImagePickerControllerReferenceURL];
        pickedAsset = [AVAsset assetWithURL:pickedAssetURL];
        pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if(_completitionBlock)
        {
            _completitionBlock(pickedImage,nil);
        }
    }
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
}
- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{

    [m_controller dismissViewControllerAnimated:NO completion:nil];
}

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {

    [m_controller dismissViewControllerAnimated:NO completion:nil];
}

-(void)actionTakePhoto
{
    [_sharedInstance loadAssetFromViewController:hostViewController WithAssetType:(NSString*)kUTTypeImage andUIImagePickerControllerSourceType:UIImagePickerControllerSourceTypeCamera andGetDataCompletitionBlock:^(id obj, NSError *err) {
        if(err)
        {
            mCompleteHandler(nil,err);
            return;
        }
        UIImage* img=(UIImage*)obj;
        if (img) {
            NSData *pngImageData = UIImagePNGRepresentation(img);
            
            if(pngImageData) {
                mCompleteHandler(pngImageData,nil);
            }
            else{
                mCompleteHandler(nil,[NSError unexpectedError]);
            }
        }
    }];
    [addPotoMenu removeFromSuperview];
}
-(void)actionChoosePhoto
{
    [_sharedInstance loadAssetFromViewController:hostViewController WithAssetType:(NSString*)kUTTypeImage andUIImagePickerControllerSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum andGetDataCompletitionBlock:^(id obj, NSError *err) {
        if(err)
        {
            mCompleteHandler(nil,err);
            return;
        }
        UIImage* img=(UIImage*)obj;
        if (img) {
            NSData *pngImageData = UIImagePNGRepresentation(img);
            
            if(pngImageData) {
                mCompleteHandler(pngImageData,nil);
            }
            else{
                mCompleteHandler(nil,[NSError unexpectedError]);
            }
        }
    }];
    [addPotoMenu removeFromSuperview];
}
-(void)actionDelete
{
    mCompleteHandler(nil,nil);
    [addPotoMenu removeFromSuperview];
}
-(void)actionHide
{
    [addPotoMenu removeFromSuperview];
}

@end
