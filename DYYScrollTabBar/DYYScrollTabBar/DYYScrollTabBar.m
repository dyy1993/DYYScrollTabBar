//
//  DYYScrollTabBar.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "DYYScrollTabBar.h"
#import "DYYScrollTabBarConfig.h"
#define MIN_MAGIN 20
@interface DYYScrollTabBar()
@property (nonatomic, strong)DYYScrollTabBarConfig *config;

@property (nonatomic, strong)UIScrollView *contentView;
@property (nonatomic, strong)NSMutableArray <UIButton *> *itemBtns;
@property (nonatomic, strong)UIView *indicatorView;
@property (nonatomic, assign)NSInteger selectIndex;


@end
@implementation DYYScrollTabBar

+ (instancetype)scrollTabBarWithFrame:(CGRect)frame{

    return [[DYYScrollTabBar alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = self.config.scrollTabBarBackgroundColor;
    }
    return self;
}

-(void)setItems:(NSArray<NSString *> *)items{

    _items = items;
    
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString *title in items) {
        
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
        
        btn.tag = self.itemBtns.count;
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
        
        
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)btnClick:(UIButton *)btn{

    
}
#pragma mark - 布局控件
-(void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat totalBtnWith = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWith += btn.frame.size.width;
    }
    CGFloat magin = 0;
    magin = (self.bounds.size.width - totalBtnWith) / (self.itemBtns.count + 1);
    if (magin < MIN_MAGIN) {
        magin = MIN_MAGIN;
    }
    CGFloat last_x = magin;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        CGRect frame = btn.frame;
        frame.origin.x = last_x;
        frame.origin.y = 0;
        btn.frame = frame;
        
        last_x += btn.frame.size.width + magin;
        
        }
    self.contentView.contentSize = CGSizeMake(last_x, 0);
    
    if (self.itemBtns.count == 0) {
        return;
    }
    UIButton *btn = self.itemBtns[self.selectIndex];
    CGFloat indicatorW = btn.frame.size.width + self.config.indicatorExtraW * 2;
    CGFloat indicatorY = self.frame.size.height - self.config.indicatorHeight;
    CGRect frame = CGRectMake(0, indicatorY, indicatorW, self.config.indicatorHeight);
    self.indicatorView.frame = frame;
    
    CGPoint point = self.indicatorView.center;
    point.x = btn.center.x;
    self.indicatorView.center = point;
    
    
}

#pragma mark - lazy
-(DYYScrollTabBarConfig *)config {

    if (!_config) {
        _config = [DYYScrollTabBarConfig defaultConfig];
    }
    return _config;
}
-(NSMutableArray<UIButton *> *)itemBtns{

    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}
-(UIView *)indicatorView{

    if (!_indicatorView) {
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - self.config.indicatorHeight, 0, self.config.indicatorHeight)];
        indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

-(UIScrollView *)contentView{

    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}


@end
