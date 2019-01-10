//
//  AppDelegate.h
//  ApiCall
//
//  Created by subramanyam on 20/02/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTabBarController.h"
#define UIAppDelegate \ ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) MHTabBarController *rootTab;
@property (strong, nonatomic) UIImage *croppedImage;

@end

