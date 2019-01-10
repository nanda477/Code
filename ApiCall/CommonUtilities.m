//
//  CommonUtilities.m
//  ApiCall
//
//  Created by subramanyam on 03/03/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import "CommonUtilities.h"
#import "Menu.h"
#import "WhatsNew.h"
#import "UserProfiles.h"

@implementation CommonUtilities
+(MHTabBarController *)getTabbarController
{
    
    UserProfiles *user=[[UserProfiles alloc]initWithNibName:@"UserProfiles" bundle:nil];
    //user.myProfile=YES;
    WhatsNew *whats=[[WhatsNew alloc]initWithNibName:@"WhatsNew" bundle:nil];
    Menu *menu=[[Menu alloc]initWithNibName:@"Menu" bundle:nil];
    
    user.title = @"user";
    whats.title = @"whats new";
    menu.title =@"Menu";
    
    NSArray *viewControllers = @[whats,menu,user];
    MHTabBarController *tabBarController = [[MHTabBarController alloc] init];
    
    
    
    tabBarController.delegate = self;
    tabBarController.viewControllers = viewControllers;


    return tabBarController;
}

@end
