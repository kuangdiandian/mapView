//
//  UIView+frame.h
//  综合项目
//
//  Created by xiaomage on 16/11/12.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

/**
 
 在分类当中能不能添加属性,如果想要添加应该怎么做?
 1.在分类当中一般情况下, 是不能添加属性的.
 2.如果说非要添加属性的话, 必须得要实现该属性的set与get方法.如果不实现该,可以在属性前声明@dynamic
   或者自己去实现它的get与set方法.
 3.在分类当中使用@property是会声明get与set方法.没有帮你实现
 4.在分类当中不会生成带有下划线的成员属性.
 
 
 
 什么情况下自定义类
 1.当要重写系统类的方法时, 必须得要自定义类
 2.当发现系统类没有办法瞒足自己需求时, 自定义类,继承系统的类,在子类当中添加属性自己的东西.
 3.想要办谁的事情谁来管理时,可以自定义, 把属于它的东西写到内部去, 让代码的结构更加清晰.
 
 */


@property(nonatomic, assign) CGFloat kgb_x;
@property(nonatomic, assign) CGFloat kgb_y;
@property(nonatomic, assign) CGFloat kgb_width;
@property(nonatomic, assign) CGFloat kgb_height;
@property(nonatomic,assign) CGSize  kgb_size;

//中心点的 x 值
@property(nonatomic, assign) CGFloat kgb_centerX;
@property(nonatomic,assign) CGFloat  kgb_centerY;
@end
