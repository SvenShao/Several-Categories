//
//  UIView+Extention.m
//  Several-Categories
//
//  Created by sven on 14-10-11.
//  Copyright (c) 2014年 sven. All rights reserved.
//

#import "UIView+Extention.h"

@implementation UIView (Extention)

- (float)frameX {
    return self.frame.origin.x;
}

- (float)frameY {
    return self.frame.origin.y;
}

- (float)width {
    return self.bounds.size.width;
}

- (float)height {
    return self.bounds.size.height;
}

//UIView截图
- (UIImage *)convertedImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}


- (void)convertImage:(void (^)(UIImage *))block {
    UIImage *image = [self convertedImage];
    block(image);
}


@end
