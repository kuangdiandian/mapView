//
//  UIView+frame.m
//  综合项目
//
//  Created by xiaomage on 16/11/12.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

//@dynamic x;
//@dynamic y;
//@dynamic width;
//@dynamic height;

- (CGFloat)kgb_x {
    return self.frame.origin.x;
}

- (void)setKgb_x:(CGFloat)kgb_x {
    
    CGRect frame = self.frame;
    frame.origin.x = kgb_x;
    self.frame = frame;
    
}

- (CGFloat)kgb_y {
    return self.frame.origin.y;
}

- (void)setKgb_y:(CGFloat)kgb_y {
    CGRect frame = self.frame;
    frame.origin.y = kgb_y;
    self.frame = frame;
}

- (CGFloat)kgb_width {
    return self.frame.size.width;
}
-(void)setKgb_width:(CGFloat)kgb_width{
    CGRect frame = self.frame;
    frame.size.width = kgb_width;
    self.frame = frame;
}


- (CGFloat)kgb_height {
    return self.frame.size.height;
}
-(void)setKgb_height:(CGFloat)kgb_height {
    CGRect frame = self.frame;
    frame.size.height = kgb_height;
    self.frame = frame;
}


- (CGSize)kgb_size {
    return self.frame.size;
}
-(void)setKgb_size:(CGSize)kgb_size
{
    CGRect frame = self.frame;
    frame.size = kgb_size;
    self.frame = frame;
}



- (CGFloat)kgb_centerX {
    return self.center.x;
}
-(void)setKgb_centerX:(CGFloat)kgb_centerX
{
    
    CGPoint temp = self.center;
    temp.x = kgb_centerX;
    self.center = temp;
}


- (CGFloat)kgb_centerY {
    return self.center.x;
}
-(void)setKgb_centerY:(CGFloat)kgb_centerY
{
    
    CGPoint temp = self.center;
    temp.y = kgb_centerY;
    self.center = temp;
}



@end
