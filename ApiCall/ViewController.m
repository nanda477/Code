//
//  ViewController.m
//  ApiCall
//
//  Created by subramanyam on 20/02/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import "ViewController.h"
#import "DataBase.h"
#import "SecondVcTableCell.h"
#import "AppDelegate.h"
#import "CommonUtilities.h"
#import "TabBarViewController.h"

#define UIAppDelegate \ ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface ViewController ()
{
    NSArray *resultArray1;
    NSArray *resultArray2;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

      AppDelegate *appDelegate=( AppDelegate* )[UIApplication sharedApplication].delegate;
       [CommonUtilities getTabbarController];
    //  UIAppDelegate.rootTab=[CommonUtilities getTabbarController];
    //[CommonUtilities getTabbarController];
    
   self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"yes.png"]];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    //_uName.layer.backgroundColor = [UIColor blackColor].CGColor;
    
//do operation in background
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0) ,^{
        
        [JsnParser getJsonResponse:@"http://api.pss.mahiti.org/api/GetQuestionList?lang_id=1"
        
        success:^(NSDictionary *responseDict)
        {
            
            NSLog(@"result %@",responseDict);
            
            resultArray1=[[NSArray alloc]init];
            resultArray1=[responseDict objectForKey:@"choices"];
            resultArray2=[[NSArray alloc]init];
            resultArray2=[responseDict objectForKey:@"questions"];
            NSLog(@"%@",resultArray1);
            NSLog(@"%@",resultArray2);
            NSMutableArray *keyArray=[[NSMutableArray alloc]init];
            NSMutableArray *patArray=[[NSMutableArray alloc]init];
            NSMutableArray *idArray=[[NSMutableArray alloc]init];
            NSMutableArray *decArray2=[[NSMutableArray alloc]init];
            
    for (int i=0; i<[resultArray1 count]; i++)
            {
                [keyArray addObject:[[resultArray1 objectAtIndex:i]objectForKey:@"key"]];
                [patArray addObject:[[resultArray1 objectAtIndex:i]objectForKey:@"patientTypeID"]];
                
                if ([[[resultArray1 objectAtIndex:i]objectForKey:@"patientTypeID"] isEqual:@"1"])
                {
                    [idArray addObject:[[resultArray1 objectAtIndex:i] objectForKey:@"id"]];
                    
                }
                
                
            }
            for (int i=0; i < [resultArray2 count]; i++) {
                [decArray2 addObject:[[resultArray2 objectAtIndex:i]objectForKey:@"description"]];
            }
            NSLog(@"%@",keyArray);
            NSLog(@"%@",patArray);
            NSLog(@"%@",idArray);
            NSLog(@"%@",decArray2);
        }
        failure:^(NSError *error)
        {
             NSLog(@"error");
        }
         
        ];
        
        
                  //background
          dispatch_async(dispatch_get_main_queue(), ^{
                 //main thread
              // update ui on main 
          });
    });
    
   

}
-(void)swipeAction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"myLnk" sender:nil];
    });
    //    [UIAppDelegate.rootTab setSelectedViewController:[UIAppDelegate.rootTab.viewControllers objectAtIndex:3] animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUPAction:(id)sender
{
    BOOL success = NO;
    if (_uName.text.length>0 && _uPassword.text.length>0 &&
        _uMail.text.length>0 && _uphno.text.length>0 )
    {
        success = [[DataBase getSharedInstance]saveDataname:_uName.text password:_uPassword.text email:_uMail.text phno:_uphno.text];
        NSLog(@"Data Saved Successfully");
        _uName.text =@"";
        _uMail.text =@"";
        _uphno.text = @"";
        _uPassword.text = @"";
        
    }
    else
    {
        NSLog(@"Data Not Saved Successfully");
    }
    if (success == NO)
    {
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Saves" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [myAlert addAction:okButton];
        [self presentViewController:myAlert animated:YES completion:nil];
    }
}
- (IBAction)signInAction:(id)sender
{
    NSArray *data = [[DataBase getSharedInstance]findByname:_suName.text password:_suPassword.text];
    if (data == nil) {
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Data not Found" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [myAlert addAction:okButton];
        [self presentViewController:myAlert animated:YES completion:nil];
        _suPassword.text=@"";
        _suName.text=@"";
        
    }
    else
    {
        _suPassword.text=@"";
        _suName.text=@"";
        [self performSegueWithIdentifier:@"myLnk" sender:nil];
    }
    
}

- (IBAction)dbDataAction:(id)sender
{
    [self performSegueWithIdentifier:@"myLnk" sender:nil];
}

- (IBAction)tabBarAction:(id)sender
{
   TabBarViewController *myTab = [[TabBarViewController alloc]initWithNibName:@"TabBarViewController" bundle:nil];

   // UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:myTab];


    [self presentViewController:myTab animated:YES completion:nil];

  
}


@end
