//
//  ViewController.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "ViewController.h"
#import "DYYScrollTabBarController.h"
#import "Test2ViewController.h"
@interface ViewController ()
@property (nonatomic, strong) DYYScrollTabBarController *scrollTabBarController;
@end

@implementation ViewController
-(DYYScrollTabBarController *)scrollTabBarController{
    if (!_scrollTabBarController) {
        DYYScrollTabBarController *scrollTabBarController = [[DYYScrollTabBarController alloc] init];
        [self addChildViewController:scrollTabBarController];
        _scrollTabBarController = scrollTabBarController;
    }
    return _scrollTabBarController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"scrollTabBar";

//    self.navigationController.navigationBarHidden = YES;
//    self.scrollTabBarController.scrollTabBar.frame = CGRectMake(0, 0, 300, 35);
//    self.scrollTabBarController.scrollTabBar.backgroundColor = [UIColor blueColor];
//    self.navigationItem.titleView = self.scrollTabBarController.scrollTabBar;
    self.scrollTabBarController.view.frame = self.view.bounds;
    [self.view addSubview:self.scrollTabBarController.view];
    
    Test2ViewController *vc1 = [[Test2ViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    Test2ViewController *vc2 = [[Test2ViewController alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    Test2ViewController *vc3 = [[Test2ViewController alloc] init];
    vc3.view.backgroundColor = [UIColor greenColor];
    Test2ViewController *vc4 = [[Test2ViewController alloc] init];
    vc4.view.backgroundColor = [UIColor blueColor];
    Test2ViewController *vc5 = [[Test2ViewController alloc] init];
    vc5.view.backgroundColor = [UIColor brownColor];
    Test2ViewController *vc6 = [[Test2ViewController alloc] init];
    vc6.view.backgroundColor = [UIColor brownColor];
    [self.scrollTabBarController setUpWithItems:@[@"英雄联盟",@"守望先锋",@"暗黑",@"美颜",@"野外直播",@"娱乐天地"] childVCs:@[vc1,vc2,vc3,vc4,vc5,vc6]];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.scrollTabBarController.scrollTabBar updateWithConfig:^(DYYScrollTabBarConfig *config) {
//            
//            config.scrollTabBarBackgroundColor = [UIColor blueColor];
//            config.itemNormalColor = [UIColor blackColor];
//            config.itemSelectColor = [UIColor greenColor];
//            config.itemFont = [UIFont systemFontOfSize:16];
//            config.indicatorColor = [UIColor redColor];
//            config.indicatorHeight = 2;
//            config.indicatorExtraW = 0;
//        }];
//    });
    
}

@end
