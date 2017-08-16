//
//  DYYScrollTabBar.h
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYYScrollTabBarConfig.h"
@interface DYYScrollTabBar : UIView

/**
 快速创建一个选项卡控件
 
 @param frame frame
 
 @return 选项卡控件
 */
+ (instancetype)scrollTabBarWithFrame:(CGRect)frame;

@property (nonatomic, strong)NSArray <NSString *> *items;
@end
