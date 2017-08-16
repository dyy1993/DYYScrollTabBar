//
//  ViewController.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "ViewController.h"
#import "DYYScrollTabBarController.h"
#import "TestViewController.h"
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
    
    self.scrollTabBarController.scrollTabBar.frame = CGRectMake(0, 0, 300, 35);
    self.scrollTabBarController.scrollTabBar.backgroundColor = [UIColor blueColor];
    self.navigationItem.titleView = self.scrollTabBarController.scrollTabBar;
    self.scrollTabBarController.view.frame = self.view.bounds;
    [self.view addSubview:self.scrollTabBarController.view];
    
    Test2ViewController *vc1 = [[Test2ViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    Test2ViewController *vc2 = [[Test2ViewController alloc] init];
    vc2.view.backgroundColor = [UIColor grayColor];
    Test2ViewController *vc3 = [[Test2ViewController alloc] init];
    vc3.view.backgroundColor = [UIColor greenColor];
    [self.scrollTabBarController setUpWithItems:@[@"hh",@"dd",@"ff"] childVCs:@[vc1,vc2,vc3]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
