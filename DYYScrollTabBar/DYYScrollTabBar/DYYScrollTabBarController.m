//
//  DYYScrollTabBarController.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "DYYScrollTabBarController.h"
#import "DYYScrollTabBarHeader.h"
@interface DYYScrollTabBarController ()<UIScrollViewDelegate, DYYScrollTabBarDelegate>
@property (nonatomic, strong)UIScrollView *contentView;

@end

@implementation DYYScrollTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
}

- (void)setUpWithItems:(NSArray <NSString *>*)items childVCs:(NSArray <UIViewController *>*)childVCs{
    NSAssert(items.count != 0 && items.count == childVCs.count, @"控制器与标题数量不一致, 请传相同数量");

    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    self.scrollTabBar.items = items;

    for (UIViewController *VC in childVCs) {
        [self addChildViewController:VC];
    }
    self.contentView.contentSize = CGSizeMake(self.view.bounds.size.width * childVCs.count, 0);
    self.scrollTabBar.selectIndex = 0;


    
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
#pragma mark - scrollTabBarDelegate
-(void)scrollTabBar:(DYYScrollTabBar *)scrollTabBar didSelectIndex:(NSInteger)selectIndex{

    [self showChildViewAtIndex:selectIndex];

}
#pragma mark - scrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;

    self.scrollTabBar.selectIndex = index;
}
#pragma mark - 布局

-(void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    NSLog(@"布局子控件");

    if (self.scrollTabBar.superview == self.view) {
        CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;

        CGFloat titleY = self.navigationController.navigationBarHidden == NO ? 64 : statusH;
        
        self.scrollTabBar.frame = CGRectMake(0, titleY, self.view.frame.size.width, DYYTitleScrollViewH);
        
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
        UIScrollView *contentView = [[UIScrollView alloc] init];
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
        scrollTabBar.delegate = self;
        [self.view addSubview:scrollTabBar];
        _scrollTabBar = scrollTabBar;
    }
    return _scrollTabBar;
}
@end
