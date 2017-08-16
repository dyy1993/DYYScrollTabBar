//
//  DYYScrollTabBarConfig.h
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DYYScrollTabBarConfig : NSObject

+ (instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *scrollTabBarBackgroundColor;

@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) CGFloat indicatorExtraW;


@end
