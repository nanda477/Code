//
//  SecondViewController.m
//  ApiCall
//
//  Created by subramanyam on 02/03/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import "SecondViewController.h"
#import "DataBase.h"
#import "SecondVcTableCell.h"
@interface SecondViewController ()
{
    NSArray *dbResult;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dbResult = [[DataBase getSharedInstance]allData];
    NSLog(@"%@",dbResult);
    
    NSLog(@"%lu",(unsigned long)dbResult.count);
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
//table delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dbResult.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCell = @"cell";
    SecondVcTableCell* cellT = [tableView dequeueReusableCellWithIdentifier:myCell];
    cellT.nameL.text =[[dbResult objectAtIndex:indexPath.row]objectForKey:@"name"];
    cellT.mailL.text = [[dbResult objectAtIndex:indexPath.row]objectForKey:@"mail"];
    cellT.phL.text = [[dbResult objectAtIndex:indexPath.row]objectForKey:@"phno"];
    return cellT;
}

@end
