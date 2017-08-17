//
//  DYYScrollTabBarConfig.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "DYYScrollTabBarConfig.h"

@implementation DYYScrollTabBarConfig
+ (instancetype)defaultConfig{
    DYYScrollTabBarConfig *config = [[DYYScrollTabBarConfig alloc] init];
    config.scrollTabBarBackgroundColor = [UIColor whiteColor];
    config.itemNormalColor = [UIColor grayColor];
    config.itemSelectColor = [UIColor redColor];
    config.itemFont = [UIFont systemFontOfSize:14];
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 5;

    return config;
}

@end
