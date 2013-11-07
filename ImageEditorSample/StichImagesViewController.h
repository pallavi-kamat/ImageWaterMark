//
//  StichImagesViewController.h
//  ImageEditorSample
//
//  Created by Mac-4 on 07/06/13.
//  Copyright (c) 2013 Pallavi Kamat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StichImagesViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    IBOutlet UIImageView *imageView3;
    int isFromImageView;
}
-(IBAction)buttonAddImage;
-(void)addImage1:(id)sender;
-(void)addImage2:(id)sender;
-(void)addImage3:(id)sender;
-(IBAction)CombineImage:(id)sender;
- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
@end
