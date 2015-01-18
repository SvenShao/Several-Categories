//
//  UIView+Extention.h
//  Several-Categories
//
//  Created by sven on 14-10-11.
//  Copyright (c) 2014年 sven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extention)

- (float)frameX;

- (float)frameY;

- (float)width;

- (float)height;


//返回UIView的截图
- (UIImage *)convertedImage;
//block方式
- (void)convertImage:(void (^)(UIImage *))block;

@end
