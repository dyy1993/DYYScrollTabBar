//
//  DYYScrollTabBarController.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "DYYScrollTabBarController.h"

@interface DYYScrollTabBarController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *contentView;

@end

@implementation DYYScrollTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
}

- (void)setUpWithItems:(NSArray <NSString *>*)items childVCs:(NSArray <UIViewController *>*)childVCs{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致, 请自己检查");

    
    [childVCs makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    for (UIViewController *VC in childVCs) {
        [self addChildViewController:VC];
    }
    self.contentView.frame = self.view.bounds;
    self.contentView.contentSize = CGSizeMake(self.view.bounds.size.width * childVCs.count, 0);
    self.scrollTabBar.items = items;
    [self showChildViewAtIndex:0];

    
}

- (void)showChildViewAtIndex:(NSInteger)index{

    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *VC = self.childViewControllers[index];
    [self.contentView addSubview:VC.view];
    VC.view.frame = CGRectMake(self.contentView.frame.size.width * index, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    [self.contentView setContentOffset:CGPointMake(VC.view.frame.origin.x, 0) animated:YES];
    
}
#pragma mark - scrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self showChildViewAtIndex:index];

}
#pragma mark - 布局

-(void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    if (self.scrollTabBar.superview == self.view) {
        self.scrollTabBar.frame = CGRectMake(0, 60, self.view.frame.size.width, 40);
        
        self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.scrollTabBar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.scrollTabBar.frame));
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.frame.size.width, 0);
        return;
        
    }
    
    self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.frame.size.width, 0);
    
}
#pragma mark - layz

-(UIScrollView *)contentView{

    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}
-(DYYScrollTabBar *)scrollTabBar {
    
    if (!_scrollTabBar) {
        DYYScrollTabBar *scrollTabBar = [DYYScrollTabBar scrollTabBarWithFrame:CGRectZero];
        [self.view addSubview:scrollTabBar];
        _scrollTabBar = scrollTabBar;
    }
    return _scrollTabBar;
}
@end
