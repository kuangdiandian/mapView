//
//  KGBTextSize.h
//  MyWeiXin
//
//  Created by 邝贵斌 on 17/3/10.
//  Copyright © 2017年 kuangguibin. All rights reserved.
//

//通过一段文字计算出文字的尺寸

#import <Foundation/Foundation.h>

@interface KGBTextSize : NSObject


/**
 文字不换行计算宽高

 @param titleFont 字体
 @param titleLabel 要计算的文字
 */
+(CGSize)kgb_titleLabelSize:(UIFont*)titleFont label:(NSString*)titleLabel;



/**
 文字换行计算宽高

 @param titleFont 字体
 @param titleLabel 要计算的文字
 @param maxW 文字最大宽度
 */
//注意点: 记得设置文字的 numberOfLines 属性为0
+(CGSize)kgb_muchLineTitleSize:(UIFont*)titleFont maxW:(CGFloat)maxW label:(NSString*)titleLabel;
@end
