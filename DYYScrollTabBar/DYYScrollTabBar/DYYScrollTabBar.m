//
//  DYYScrollTabBar.m
//  DYYScrollTabBar
//
//  Created by yang on 2017/8/15.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

#import "DYYScrollTabBar.h"
#import "DYYScrollTabBarConfig.h"
#import "DYYScrollTabBarHeader.h"
@interface DYYScrollTabBar(){

    UIButton *_lastBtn;
}
@property (nonatomic, strong)DYYScrollTabBarConfig *config;

@property (nonatomic, strong)UIScrollView *contentView;
@property (nonatomic, strong)NSMutableArray <UIButton *> *itemBtns;
@property (nonatomic, strong)UIView *indicatorView;


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
-(void)updateWithConfig:(void(^)(DYYScrollTabBarConfig *config))configBlock{

    if (configBlock) {
        configBlock(self.config);
    }
    
    self.backgroundColor = self.config.scrollTabBarBackgroundColor;
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
    }
    
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];

}
-(void)setSelectIndex:(NSInteger)selectIndex{
    
    _selectIndex = selectIndex;
    [self btnClick:self.itemBtns[selectIndex]];
    
}
- (void)btnClick:(UIButton *)btn{

    if ([self.delegate respondsToSelector:@selector(scrollTabBar:didSelectIndex:)]) {
        [self.delegate scrollTabBar:self didSelectIndex:btn.tag];
    }
    _selectIndex = btn.tag;
    _lastBtn.selected = NO;
    btn.selected = YES;
    
    _lastBtn = btn;

    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.indicatorView.frame;
        frame.size.width = btn.frame.size.width + self.config.indicatorExtraW * 2;
        self.indicatorView.frame = frame;
        
        CGPoint center = self.indicatorView.center;
        center.x = btn.center.x;
        self.indicatorView.center = center;
    }];
    
    CGFloat scrollX = btn.center.x - self.contentView.frame.size.width * 0.5;
    if (scrollX < 0 || self.contentView.frame.size.width == 0) {
        scrollX = 0;
    }
    CGFloat maxScrollX = self.contentView.contentSize.width - self.contentView.frame.size.width;
    if (scrollX > maxScrollX) {
        scrollX = maxScrollX;
    }
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
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
    if (magin < DYYMinMagin) {
        magin = DYYMinMagin;
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
    self.contentView.frame = self.bounds;

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
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}


@end
