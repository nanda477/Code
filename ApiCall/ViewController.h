//
//  ViewController.h
//  ApiCall
//
//  Created by subramanyam on 20/02/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsnParser.h"


@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *uName;
@property (weak, nonatomic) IBOutlet UITextField *uPassword;
@property (weak, nonatomic) IBOutlet UITextField *uMail;
@property (weak, nonatomic) IBOutlet UITextField *uphno;
- (IBAction)signUPAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *suName;
@property (weak, nonatomic) IBOutlet UITextField *suPassword;
- (IBAction)signInAction:(id)sender;
- (IBAction)dbDataAction:(id)sender;
- (IBAction)tabBarAction:(id)sender;


@end

