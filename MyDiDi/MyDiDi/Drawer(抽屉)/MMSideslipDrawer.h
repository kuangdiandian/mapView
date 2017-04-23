//
//  MMSideslipDrawer.h
//  MMSideslipDrawer
//
//  Created by LEA on 2017/2/17.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Category.h"



#define kMMSideslipTopHeight    180
#define kMMSideslipMainColor    [UIColor colorWithRed:74.0/255.0 green:75.0/255.0 blue:90.0/255.0 alpha:1.0]


@class MMSideslipItem;
@protocol MMSideslipDrawerDelegate;
@interface MMSideslipDrawer : UIView

//展示的数据Model
@property (nonatomic, strong) MMSideslipItem *item;
//代理
@property (nonatomic, assign) id<MMSideslipDrawerDelegate> delegate;

//外部接口
- (instancetype)initWithDelegate:(id<MMSideslipDrawerDelegate>)delegate slipItem:(MMSideslipItem *)item;
- (void)colseLeftDrawerSide;
- (void)openLeftDrawerSide:(UIView *)view;

@end

@protocol MMSideslipDrawerDelegate <NSObject>

@optional

//查看列表项信息
- (void)slipDrawer:(MMSideslipDrawer *)slipDrawer didSelectAtIndex:(NSInteger)index;
//查看用户信息
- (void)didViewUserInformation:(MMSideslipDrawer *)slipDrawer;
//查看会员等级信息
- (void)didViewVIPInformation:(MMSideslipDrawer *)slipDrawer;

@end


@interface MMSideslipItem : NSObject

//头像路径[网络路径，需引入SDWebImage]
@property (nonatomic,copy) NSString *thumbnailPath;
//名称
@property (nonatomic,copy) NSString *name;
//会员
@property (nonatomic,copy) NSString *vip;
//会员图片名称
@property (nonatomic,copy) NSString *vipImageName;
//列表项名称数组（用于cell.textLabel.text）
@property (nonatomic,copy) NSArray *textArray;
//列表项图片名称数组 (用于cell.imageView.image）
@property (nonatomic,copy) NSArray *imageNameArray;

@end
