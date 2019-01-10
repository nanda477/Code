//
//  SecondViewController.h
//  ApiCall
//
//  Created by subramanyam on 02/03/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end
