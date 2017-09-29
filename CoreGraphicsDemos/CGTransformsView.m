//
//  CGUIImageView.m
//  CoreGraphicsDemos
//
//  Created by Qi Xin on 28/9/2017.
//  Copyright © 2017 Qi Xin. All rights reserved.
//

#import "CGTransformsView.h"

#import <CoreText/CoreText.h>

#include <math.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

#pragma mark - modifyTheCurrentTransformsMatrix

void resetTheCTMBackToTheQuartzCoordinate(CGContextRef context)
{
    size_t height = CGBitmapContextGetHeight(context);
    
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGContextTranslateCTM(context, 0.0f, height / -3.0f);
   
    /*
    UIGraphicsPushContext(context);
    
    [[UIImage imageNamed:@"Silencer"] drawInRect:CGRectMake(0, 0, 300, 300)];
    
    UIGraphicsPopContext();
     */
}

void translateCTM(CGContextRef context, CGFloat translationX, CGFloat translationY, Boolean affine)
{
    if (!affine){
        CGContextTranslateCTM(context, translationX, translationY);
    }else {
        CGAffineTransform translation = CGAffineTransformMakeTranslation(translationX, translationY);
        CGContextConcatCTM(context, translation);
    }
}

void rotateCTM(CGContextRef context, double rotation, Boolean affine)
{
    if (!affine) {
        CGContextRotateCTM(context, radians(rotation));
    }else {
        CGAffineTransform rotationTransfrom = CGAffineTransformMakeRotation(radians(45.0f));
        CGContextConcatCTM(context, rotationTransfrom);
    }
}

void scaleCTM(CGContextRef context, CGFloat scaleX, CGFloat scaleY, Boolean affine)
{
    if (!affine) {
        CGContextScaleCTM(context, scaleX, scaleY);
    }else {
        CGAffineTransform scale = CGAffineTransformMakeScale(scaleX, scaleY);
        CGContextConcatCTM(context, scale);
    }
}

@interface CGTransformsView()
{
    UIImageView *imageView;
}
@end

@implementation CGTransformsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        [self addSubview:imageView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */

- (void)drawRect:(CGRect)rect {

    [self modifyTheCurrentTransformsMatrix];
}

- (void)modifyTheCurrentTransformsMatrix
{
    CGImageRef targetImage = [UIImage imageNamed:@"Silencer"].CGImage;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSaveGState(context);
//    CGContextRestoreGState(context);
    
    //1.把CTM转化为Quartz坐标系。
    //解释：UIGraphicsGetCurrentContext()返回的是UIKit坐标系，与Quartz不一样(UIKit Y轴向下，Quartz向上)
    resetTheCTMBackToTheQuartzCoordinate(context);
    
    //2.对CTM做变换。
//    translateCTM(context, 100.0f, 100.0f, NO);
    
//    rotateCTM(context, -45.0f, YES);
    
//    scaleCTM(context, 0.6f, 0.6f, YES);
    
    //3.把图片绘制到上下文中。
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, 300, 300), targetImage);
    
    //4.获取当前上下文中的图片，并展示到imageview上。
    UIImage *modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    imageView.image = modifiedImage;
    

}
@end
