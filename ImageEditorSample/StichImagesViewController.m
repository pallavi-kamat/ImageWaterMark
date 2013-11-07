//
//  StichImagesViewController.m
//  ImageEditorSample
//
//  Created by Mac-4 on 07/06/13.
//  Copyright (c) 2013 Pallavi Kamat. All rights reserved.
//

#import "StichImagesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShowImageViewController.h"

@interface StichImagesViewController ()

@end

@implementation StichImagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage1:)];
    [imageView1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage2:)];
    [imageView2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage3:)];
    [imageView3 addGestureRecognizer:tap3];
    isFromImageView = 0;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonAddImage {
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
     [self presentModalViewController:photoPicker animated:YES];
}

-(IBAction)CombineImage:(id)sender {
    UIImage *bottomImage = imageView1.image; //background image
    UIImage *image       = imageView2.image; //foreground image
    
    CGSize newSize = CGSizeMake(300, 400);
    UIGraphicsBeginImageContext( newSize );
    
    // Use existing opacity as is
    [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Apply supplied opacity if applicable
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:0.8];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsBeginImageContext(CGSizeMake(320, 317));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
   // [imageView2 setImage:image2];
    [imageView3 setImage:newImage];
   /* ShowImageViewController *showImageViewController = [[ShowImageViewController alloc] initWithNibName:@"ShowImageViewController" bundle:nil];
    showImageViewController.image = image2;
    [self presentModalViewController:showImageViewController animated:YES];
    UIGraphicsEndImageContext();*/
   // [imageView3 setImage:[self maskImage:imageView1.image withMask:imageView2.image]];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    switch (isFromImageView) {
        case 0:
            [imageView1 setImage:originalImage];
            break;
            
        case 1:
            [imageView2 setImage:originalImage];
            break;
        
        case 2:
            [imageView3 setImage:originalImage];
            break;

        default:
            break;
    }
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)photoPicker
{
    [photoPicker dismissModalViewControllerAnimated:YES];
}

-(void)addImage1:(id)sender {
    [self buttonAddImage];
    isFromImageView = 0;
}

-(void)addImage2:(id)sender {
    [self buttonAddImage];
    isFromImageView = 1;
}

-(void)addImage3:(id)sender {
    [self buttonAddImage];
    isFromImageView = 2;
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    
    return [UIImage imageWithCGImage:masked];
    
}

@end
