//
//  DocumentVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 30/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "DocsVC.h"
#import "PECropViewController.h"
#import "UIImageView+AFNetworking.h"


@interface DocumentVC : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,PECropViewControllerDelegate>{
    UIImagePickerController *cameraUI;
    UIImage *chosenImage;
}


@property (weak, nonatomic) IBOutlet UIControl *mAddDocumentNamePopUpView;
@property (weak, nonatomic) IBOutlet UITextField *mDocumentNameTF;
@property (weak, nonatomic) IBOutlet UIImageView *mDocumentIV;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) NSString   * driverID;
@property (weak, nonatomic) NSMutableDictionary  * mDataDict;
@property (weak, nonatomic) NSMutableArray  * refArray;



@property (weak, nonatomic) IBOutlet UIButton *mReplaceButton;
@property (weak, nonatomic) IBOutlet UIButton *mDeleteButton;


- (IBAction)DoumentNameSubmitButtonTap:(id)sender;
- (IBAction)ReplaceButtonTap:(id)sender;
- (IBAction)DeleteButtonTap:(id)sender;
- (IBAction)BackButtonAction:(id)sender;


@property (weak, nonatomic)NSString * documentName ;
@property (weak, nonatomic)UIImage * documentImage ;



@end
