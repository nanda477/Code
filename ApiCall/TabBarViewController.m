//
//  TabBarViewController.m
//  ApiCall
//
//  Created by subramanyam on 13/03/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import "TabBarViewController.h"
#import "PollTableViewCell.h"
#import "PollContTableViewCell.h"

@interface TabBarViewController ()
{
    NSNumber * userId;
}

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableHeaderView=_HeaderView;
    
 
//    _textfieldT.leftView = _labelT;
//    _textfieldT.inputView = _datePicker;
//    _textfieldT.inputAccessoryView = _toolBar;
    
    
 _tableView.tableHeaderView= _HeaderView;
_tableView.tableFooterView = _sectionHeader;
    
    section0edit=NO,section1edit=NO;
    intrests=[[NSMutableArray alloc]init];
    sectionTitles=[[NSMutableArray alloc]initWithObjects:@"CONTACT INFO",@"ABOUT", nil];
    titleKeys=[[NSDictionary alloc]initWithObjectsAndKeys:@"Mobile no",@"k12",@"Email id",@"k13",@"Organization",@"k8",@"Designation/Occupation",@"k7",@"Date of birth",@"k14",@"Anniversary date",@"k15",@"NAME",@"k19",@"Phone number",@"k20",@"Email id",@"k21",nil];
    NSArray *contactKeys=[[NSArray alloc]initWithObjects:@"k12",@"k13",@"k8",@"k7",@"k14",@"k15", nil];
    NSArray *spouseKeys=[[NSArray alloc]initWithObjects:@"k19",@"k20",@"k21",nil];
    keysArray=[[NSMutableArray alloc] initWithObjects:contactKeys,intrests,spouseKeys,nil];
    _tableView.separatorColor=[UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerSection =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:_sectionHeader]];
    for (UIView *v in [headerSection subviews]) {
        if ([v isKindOfClass:[UILabel class]]) {
            UILabel *lbl=(UILabel *)v;
            lbl.text=[sectionTitles objectAtIndex:section];
            lbl.backgroundColor = [UIColor purpleColor];
        }
        if ([v isKindOfClass:[UIButton class]]) {
            v.hidden=NO;
            v.hidden=(userId==0?NO:YES)||(section==2);
            UIButton *btn=(UIButton *)v;
            [btn setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"save_icon.png"] forState:UIControlStateSelected];
            btn.tag=section;
            switch (section) {
                case 0:
                    [btn setSelected:section0edit];
                    break;
                case 1:
                    [btn setSelected:section1edit];
                    
                    break;
                    
                default:
                    break;
            }
            [btn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return headerSection;
}
-(void)editAction : (id)sender
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        if (indexPath.section == 0) {
    static NSString *CellIdentifier = @"mCell";
    
    PollContTableViewCell *mCcell = (PollContTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (mCcell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PollContTableViewCell" owner:self options:nil];
        
        mCcell = [nib objectAtIndex:0];
        
        mCcell.textLabel.text = @"phno";
        mCcell.detailTextLabel.text = @"1234567890";
        //mCcell.textLabel.numberOfLines = 5;
    
        return mCcell;
    }

    }
    static NSString *CellIdentifier = @"cell";
    
    PollTableViewCell *cell = (PollTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PollTableViewCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    cell.textLabel.text = @"Fav Spot";

    cell.detailTextLabel.text = @"Bangalore";
 
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
