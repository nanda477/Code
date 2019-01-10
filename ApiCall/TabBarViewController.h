//
//  TabBarViewController.h
//  ApiCall
//
//  Created by subramanyam on 13/03/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL section0edit,section1edit;
    NSMutableArray *sectionTitles;
    NSMutableArray *intrests;
    NSMutableArray *keysArray;
    NSDictionary *titleKeys;
}
@property (weak, nonatomic) IBOutlet UILabel *labelT;
@property (weak, nonatomic) IBOutlet UITextField *textfieldT;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *sectionHeader;
@property (weak, nonatomic) IBOutlet UIView *HeaderView;
@property (weak, nonatomic) IBOutlet UIView *sectionFooter;
@property (weak, nonatomic) IBOutlet UILabel *headerL;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;

@end
