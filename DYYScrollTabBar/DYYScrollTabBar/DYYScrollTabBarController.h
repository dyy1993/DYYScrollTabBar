//
//  DYYScrollTabBarController.h
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYYScrollTabBar.h"
@interface DYYScrollTabBarController : UIViewController

@property (nonatomic, weak) DYYScrollTabBar *scrollTabBar;


- (void)setUpWithItems:(NSArray <NSString *>*)items childVCs:(NSArray <UIViewController *>*)childVCs;

@end
