//
//  DYYScrollTabBarConfig.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "DYYScrollTabBarConfig.h"
#import "DYYScrollTabBarHeader.h"
@implementation DYYScrollTabBarConfig
+ (instancetype)defaultConfig{
    DYYScrollTabBarConfig *config = [[DYYScrollTabBarConfig alloc] init];
    config.scrollTabBarBackgroundColor = [UIColor whiteColor];
    config.itemNormalColor = [UIColor grayColor];
    config.itemSelectColor = [UIColor redColor];
    config.itemFont = DYYTitleFont;
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = DYYIndicatorH;
    config.indicatorExtraW = DYYIndicatorExtraW;

    return config;
}

@end
