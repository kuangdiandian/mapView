//
//  KGBTextSize.m
//  MyWeiXin
//
//  Created by 邝贵斌 on 17/3/10.
//  Copyright © 2017年 kuangguibin. All rights reserved.
//

#import "KGBTextSize.h"

@implementation KGBTextSize


+(CGSize)kgb_titleLabelSize:(UIFont*)titleFont label:(NSString*)titleLabel{
    //  计算文字高度之前需要知道文字的字体和大小
    NSDictionary*dictSize=@{NSFontAttributeName : titleFont};
    //通过一段文字 计算出文字的宽度和高度
    CGSize  titleSize=[titleLabel   sizeWithAttributes:dictSize];
    return titleSize;
}


+(CGSize)kgb_muchLineTitleSize:(UIFont*)titleFont maxW:(CGFloat)maxW label:(NSString*)titleLabel{
    
    CGSize  textMaxSize=CGSizeMake(maxW, MAXFLOAT);
    //设置计算文字的 字体和大小
    NSDictionary*dict=@{NSFontAttributeName : titleFont};
    
    //返回的是一个Rect
    CGRect  textRect =[titleLabel    boundingRectWithSize:textMaxSize options: NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
   
    return  textRect.size;
}



@end
