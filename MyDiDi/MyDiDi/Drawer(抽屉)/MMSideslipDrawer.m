//
//  MMSideslipDrawer.m
//  MMSideslipDrawer
//
//  Created by LEA on 2017/2/17.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MMSideslipDrawer.h"

@interface MMSideslipDrawer ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *thumblImageView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *rankBtn;

@end

@implementation MMSideslipDrawer

- (instancetype)initWithDelegate:(id<MMSideslipDrawerDelegate>)delegate slipItem:(MMSideslipItem *)item;
{
    self = [super initWithFrame:CGRectMake(0, 0, KGBScreenW, KGBScreenH)];
    if (self)
    {
        self.userInteractionEnabled = YES;
        
        //## 赋值
        _delegate = delegate;
        _item = item;
        
        //## 添加视图
        [self addSubview:self.alphaView];
        [self addSubview:self.menuView];
        
        //## 更新UI
        self.thumblImageView.image = [UIImage imageWithContentsOfFile:item.thumbnailPath];
        self.nameLab.text = item.name;
        [self.rankBtn setImage:[UIImage imageNamed:item.vipImageName] forState:UIControlStateNormal];
        [self.rankBtn setTitle:item.vip forState:UIControlStateNormal];
        [self.tableView reloadData];
        
        //## 拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureCallback:)];
        [pan setDelegate:self];
        [self addGestureRecognizer:pan];
    }
    return self;
}

#pragma mark - 事件
- (void)colseLeftDrawerSide
{
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.alphaView.alpha = 0;
                         self.menuView.left =  -self.menuView.width;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)openLeftDrawerSide:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.alphaView.alpha = 0.5;
                         self.menuView.left = 0;
                     }];
}

#pragma mark - 手势处理
- (void)panGestureCallback:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [panGesture setEnabled:YES];
            self.userInteractionEnabled = YES;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            self.userInteractionEnabled = NO;
            CGPoint point = [panGesture translationInView:self];
            CGFloat left = self.menuView.left;
            left+= point.x;
            if (left > 0) {
                left = 0;
            }
            if (left < -kMMSideslipWidth) {
                left = -kMMSideslipWidth;
            }
            self.menuView.left = left;
            [panGesture setTranslation:CGPointZero inView:self.menuView];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            self.userInteractionEnabled = YES;
            //偏左向左滑，偏右向右滑
            if (self.menuView.left > -kMMSideslipWidth/4)  {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.menuView.left = 0;
                                 }];
            } else  {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.menuView.left = -kMMSideslipWidth;
                                     self.alphaView.alpha = 0;
                                 }
                                 completion:^(BOOL finished) {
                                     [self removeFromSuperview];
                                 }];
            }
            break;
        }
        default:
            break;
    }
}

- (void)tapGestureCallback:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(didViewUserInformation:)]) {
        [self.delegate didViewUserInformation:self];
    }
}

- (void)btClickedCallBack
{
    if ([self.delegate respondsToSelector:@selector(didViewVIPInformation:)]) {
        [self.delegate didViewVIPInformation:self];
    }
}

#pragma mark - 视图
-(UIView *)alphaView
{
    if (!_alphaView) {
        _alphaView = [[UIView alloc] initWithFrame:self.bounds];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseLeftDrawerSide)];
        [_alphaView addGestureRecognizer:tap];
    }
    return _alphaView;
}

- (UIView *)menuView
{
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(-kMMSideslipWidth, 0, kMMSideslipWidth, KGBScreenH)];
        _menuView.backgroundColor = [UIColor whiteColor];
        [_menuView addSubview:self.headView];
        [_menuView addSubview:self.tableView];
    }
    return _menuView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, self.headView.height, kMMSideslipWidth-20, KGBScreenH-self.headView.height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMMSideslipWidth, kMMSideslipTopHeight)];
        _headView.backgroundColor = [UIColor clearColor];
        [_headView addSubview:self.thumblImageView];
        [_headView addSubview:self.nameLab];
        [_headView addSubview:self.rankBtn];
    }
    return _headView;
}

- (UIImageView *)thumblImageView
{
    if (!_thumblImageView) {
        _thumblImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_headView.width-60)/2, (_headView.height-60-50)/2+10, 60, 60)];
        _thumblImageView.layer.cornerRadius = _thumblImageView.height/2;
        _thumblImageView.layer.masksToBounds = YES;
        _thumblImageView.userInteractionEnabled = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCallback:)];
        [_thumblImageView addGestureRecognizer:tap];
    }
    return _thumblImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(self.thumblImageView.left, self.thumblImageView.bottom+5, self.thumblImageView.width, 25)];
        _nameLab.textColor = kMMSideslipMainColor;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:18.0];
    }
    return _nameLab;
}

- (UIButton *)rankBtn
{
    if (!_rankBtn) {
        _rankBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.nameLab.left-20, self.nameLab.bottom, self.nameLab.width+40, 20)];
        _rankBtn.backgroundColor = [UIColor clearColor];
        _rankBtn.adjustsImageWhenHighlighted = NO;
        _rankBtn.titleLabel.font = [UIFont systemFontOfSize:11.0];
        [_rankBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rankBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
        [_rankBtn addTarget:self action:@selector(btClickedCallBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rankBtn;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.item.textArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.textColor = kMMSideslipMainColor;
    cell.textLabel.text = [self.item.textArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.item.imageNameArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(slipDrawer:didSelectAtIndex:)]) {
        [self.delegate slipDrawer:self didSelectAtIndex:indexPath.row];
    }
}

@end

#pragma mark - MMSideslipItem
@implementation MMSideslipItem

@end
