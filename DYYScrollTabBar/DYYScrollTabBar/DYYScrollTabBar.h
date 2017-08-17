//
//  DYYScrollTabBar.h
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYYScrollTabBarConfig.h"
@class DYYScrollTabBar;
@protocol DYYScrollTabBarDelegate <NSObject>

-(void)scrollTabBar:(DYYScrollTabBar *)scrollTabBar didSelectIndex:(NSInteger)selectIndex;
@end
@interface DYYScrollTabBar : UIView

/**
 快速创建一个选项卡控件
 
 @param frame frame
 
 @return 选项卡控件
 */
+ (instancetype)scrollTabBarWithFrame:(CGRect)frame;

@property (nonatomic, strong)NSArray <NSString *> *items;

@property (nonatomic, assign)NSInteger selectIndex;


@property (nonatomic, weak)id<DYYScrollTabBarDelegate> delegate;
-(void)updateWithConfig:(void(^)(DYYScrollTabBarConfig *config))configBlock;
@end
