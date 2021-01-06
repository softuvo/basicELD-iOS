//
//  DocumentVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 30/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "DocumentVC.h"
#import "UIImageView+WebCache.h"



@interface DocumentVC (){
    
    BOOL zoomRef;
    
    CGFloat lastScale ;

    
    bool mIsPickerEnabled;
    UIAlertView * deleteAlert ;
    UIAlertView * replaceAlert ;

    UIImage * imageToUpload ;
    

}

@end

@implementation DocumentVC
@synthesize documentName ;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.mDataDict) {
        self.mAddDocumentNamePopUpView.hidden = YES ;        
        
        NSString * string = [NSString stringWithFormat:@"%@%@",KserviceBaseImageURL,[self.mDataDict objectForKey:@"imageName"]];
        NSURL *url = [NSURL URLWithString:string];
        //[self.mDocumentIV sd_setImageWithURL:url];
        documentName = [_mDataDict valueForKey:@"documentName"];
        
        [self.mDocumentIV setImageWithURL:url placeholderImage:nil];
        
    }else{
        self.mAddDocumentNamePopUpView.hidden = NO ;
        self.mDeleteButton.hidden = YES ;
        [self.mReplaceButton setTitle:@"Add" forState:UIControlStateNormal];
    }
    
    
    deleteAlert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                             message:@"Do you want to delete this Document"
                                            delegate:self
                                   cancelButtonTitle:@"Yes"
                                   otherButtonTitles:@"No", nil];
    replaceAlert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                             message:@"Do you want to Replace this Document"
                                            delegate:self
                                   cancelButtonTitle:@"Yes"
                                   otherButtonTitles:@"No", nil];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)DoumentNameSubmitButtonTap:(id)sender {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [self.mDocumentNameTF.text stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        [Helper ISAlertTypeWarning:@"" andMessage:@"Please enter document name properly"];
        return ;
    }
    if ([self.refArray containsObject:trimmedString]) {
        [Helper ISAlertTypeWarning:@"" andMessage:@"Document already exists"];
        self.mDocumentNameTF.text = nil ;
        return ;
    }
    documentName = self.mDocumentNameTF.text;
    self.mAddDocumentNamePopUpView.hidden = YES ;
    [self ImageSelector];

}

- (IBAction)ReplaceButtonTap:(id)sender {
    if ([self.mReplaceButton.titleLabel.text isEqualToString:@"Add"]) {
        [self ImageSelector];

    }else{
        [replaceAlert show];

    }
}

- (IBAction)DeleteButtonTap:(id)sender {
   
    
    [deleteAlert show];


}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (alertView == deleteAlert) {
        if (buttonIndex == 0) {
            self.mDocumentIV.image = nil;
            [self DeleteFunction];
        }
    }else if (alertView == replaceAlert) {
        if (buttonIndex == 0) {
            [self ImageSelector];
        }
    }
    
}


- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark ---------------------------------------------------------
#pragma mark IMAGE PICKER
#pragma mark ---------------------------------------------------------

-(void)ImageSelector {
    BOOL cameraDeviceAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL photoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (cameraDeviceAvailable && photoLibraryAvailable) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [actionSheet showInView:self.view];
    } else {
        [self shouldPresentPhotoCaptureController];
    }
}



- (BOOL)shouldPresentPhotoCaptureController {
    BOOL presentedPhotoCaptureController = [self shouldStartCameraController];
    
    if (!presentedPhotoCaptureController) {
        presentedPhotoCaptureController = [self shouldStartPhotoLibraryPickerController];
    }
    
    return presentedPhotoCaptureController;
}

- (BOOL)shouldStartCameraController {
    mIsPickerEnabled  = true;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    cameraUI = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = NO;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
}


- (BOOL)shouldStartPhotoLibraryPickerController {
    mIsPickerEnabled  = true;
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
         && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return NO;
    }
    cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    } else {
        return NO;
    }
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = self;
    [self presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}



#pragma mark ---------------------------------------------------------
#pragma mark UIACTIONSHEET DELEGATE METHODS
#pragma mark ---------------------------------------------------------

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 0) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self shouldStartCameraController];
        }];
    } else if (buttonIndex == 1) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self shouldStartPhotoLibraryPickerController];
        }];
    }
}

#pragma mark ---------------------------------------------------------
#pragma mark UIIMAGEPICKER METHODS
#pragma mark ---------------------------------------------------------

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    chosenImage = info[UIImagePickerControllerOriginalImage];
  
    [picker dismissViewControllerAnimated:YES completion:^{

        PECropViewController *cropController = [[PECropViewController alloc] init];
        cropController.delegate = self;
        cropController.image = chosenImage;
        cropController.toolbarHidden = YES;

        UIImage *image = chosenImage;
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        CGFloat length = MIN(width, height);
        cropController.imageCropRect = CGRectMake((width - length) / 2,
                                                  (height - length) / 2,
                                                  length,
                                                  length);


        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cropController];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        }

        [self presentViewController:navigationController animated:nil completion:NULL];

    }];
}


#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController* )controller didFinishCroppingImage:(UIImage* )croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    self.mDocumentIV.image = croppedImage;
    imageToUpload = [UIImage imageWithCGImage:croppedImage.CGImage scale:0.25 orientation:croppedImage.imageOrientation];
    NSData *imageData = UIImageJPEGRepresentation(croppedImage, 0.5);
    NSUInteger imageSize = [imageData length];
    NSLog(@"Image Size %lu",(unsigned long)imageSize);
    [self upload];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    mIsPickerEnabled  = false;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}


-(void)upload{
    
    NSString *path = [NSString stringWithFormat:@"%@add_docs",kServiceBaseURL];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSLog(@"%@",self.driverID);
    [parameters setObject:self.driverID forKey:@"driverid"];
    [parameters setObject:documentName forKey:@"imageName"];


    [DM requestPostUrlWithImage:path parameters:parameters image:imageToUpload imageName:nil success:^(NSDictionary * _Nullable responce) {
        NSLog(@"%@",responce);
        
        if ([[responce valueForKey:@"responsestatus"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responce valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            [self BackButtonAction:self];
            self.mDeleteButton.hidden = NO;
            [self.mReplaceButton setTitle:@"Replace" forState:UIControlStateNormal];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}

-(void)DeleteFunction{
    [Helper showLoaderVProgressHUD];
    NSString *path = [NSString stringWithFormat:@"%@DeleteDoc",kServiceBaseURL];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSLog(@"%@",self.driverID);
    NSString * string  = [NSString stringWithFormat:@"%@",[_mDataDict valueForKey:@"documentName"]];

    [parameters setObject:self.driverID forKey:@"driverid"];
    [parameters setObject:string forKey:@"docName"];
    
    [DM PostRequest:path parameter:parameters onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            [self BackButtonAction:self];
           
        }
        [Helper hideLoaderSVProgressHUD];
        
    } onError:^(NSError * _Nullable Error) {
        
        
         [Helper hideLoaderSVProgressHUD];
          NSLog(@"%@",Error);
          NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
          [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];


    }];
}

- (UIImage *)compressForUpload:(UIImage *)original scale:(CGFloat)scale
{
    // Calculate new size given scale factor.
    CGSize originalSize = original.size;
    CGSize newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale);
    
    // Scale the original image to match the new size.
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}


@end
