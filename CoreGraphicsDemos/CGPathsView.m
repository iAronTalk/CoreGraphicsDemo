//
//  CGPathsView.m
//  CoreGraphicsDemos
//
//  Created by Qi Xin on 28/9/2017.
//  Copyright © 2017 Qi Xin. All rights reserved.
//

#import "CGPathsView.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}

#pragma mark - 直线绘制五角星
void cg_drawPentagramByLine(CGContextRef context, CGPoint center,CGFloat radius)
{
    CGPoint p1 = CGPointMake(center.x, center.y - radius);
    
    CGContextMoveToPoint(context, p1.x, p1.y);
    
    CGFloat angle=4 * M_PI / 5.0;
    
    for (int i=1; i<=5; i++)
    {
        CGFloat x = center.x -sinf(i*angle)*radius;
        CGFloat y = center.y -cosf(i*angle)*radius;
        CGContextAddLineToPoint(context, x, y);
    }
    
    CGContextClosePath(context);
}

CGMutablePathRef cg_drawLineByPath(CGPoint fromPoint, CGPoint toPoint)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, fromPoint.x, fromPoint.y);
    CGPathAddLineToPoint(path, nil, toPoint.x, toPoint.y);
    CGPathCloseSubpath(path);
    return path;
}

void cd_drawLines(CGContextRef context)
{
    CGPoint point2 = CGPointMake(100, 200);
    CGPoint point3 = CGPointMake(100, 300);
    CGPoint point4 = CGPointMake(200, 100);
    CGPoint points[3] = {point2, point3, point4};
    CGContextAddLines(context, points, 3);
}


#pragma mark - Arc弧线绘制圆形
void cd_drawCircleByArc(CGContextRef context, CGPoint center, CGFloat radius)
{
    CGContextAddArc(context, center.x, center.y, radius, radians(0.0f), radians(360.0f), 0);
    
    //下面两种用法可以自行研究了
//    CGContextAddArcToPoint;
//    CGContextAddQuadCurveToPoint;
}

CGMutablePathRef cd_drawArcsByPath(CGPoint fromPoint,CGPoint toPoint)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, fromPoint.x, fromPoint.y);
    CGPathAddArc(path, nil, fromPoint.x, fromPoint.y, 50, radians(-90.0f), radians((- 180.0f)), YES);
    CGPathCloseSubpath(path);
    //其他addArc方法同context创建arc的方法。
    return path;
}

#pragma mark - Curve曲线绘制大风车
void cd_drawPinwheelByCurve(CGContextRef context,CGPoint refPoint1, CGPoint refPoint2, CGPoint fromPoint, CGPoint toPoint)
{
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
    CGContextAddCurveToPoint(context, refPoint1.x, refPoint1.y, refPoint2.x, refPoint2.y, toPoint.x, toPoint.y);
    CGContextAddQuadCurveToPoint(context, refPoint1.x, refPoint1.y, toPoint.x, toPoint.y);
}

CGMutablePathRef cd_drawCurveByPath(CGPoint refPoint1, CGPoint refPoint2, CGPoint fromPoint, CGPoint toPoint)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, fromPoint.x, fromPoint.y);
    CGPathAddCurveToPoint(path, nil,refPoint1.x, refPoint1.y, refPoint2.x, refPoint2.y, toPoint.x, toPoint.y);
    CGPathCloseSubpath(path);
    //其他addCurve同context创建curve方法。
    return path;
}
#pragma mark - Ellipses椭圆
void cd_drawEllipses(CGContextRef context, CGRect rect)
{
    CGContextAddEllipseInRect(context, rect);
}

CGMutablePathRef cd_drawEllipsesByPath(CGRect rect)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddEllipseInRect(path, nil, rect);
    CGPathCloseSubpath(path);
    
    return path;
}

#pragma mark - Rectangle长方形
void cd_drawRectangle(CGContextRef context, CGRect rect)
{
    CGContextAddRect(context, rect);
}

CGMutablePathRef cd_drawRectangleByPath(CGRect rect)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddRect(path, nil, rect);
    CGPathCloseSubpath(path);
    
    return path;
}

void cd_drawRectangles(CGContextRef context)
{
    CGRect rect1 = CGRectMake(50, 20, 100, 100);
    CGRect rect2 = CGRectMake(50, 100, 200, 100);
    CGRect rect3 = CGRectMake(100, 200, 100, 100);
    CGRect rects[3] = {rect1, rect2, rect3};
    
    CGContextAddRects(context, rects, 3);
}

@interface CGPathsView()
{
    UIImageView *imageView;
}
@end

@implementation CGPathsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        [self addSubview:imageView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    [self beginLinesDemo:context];
  
    [self beginArcsDemo:context];
    
    [self beginCurvesDemo:context];
    
    [self beginEllipsesDemo:context];
    
    [self beginRectangleDemo:context];
    
    CGContextClosePath(context);
    
    //6.影响描边的属性
//    CGContextSet...
    //7.路径描边的函数
//    CGContextStroke...
    //8.填充路径
//    CGContextFill...
    
    /*其他的函数可以参考博客或者文档试着用用，看看都什么效果。okay，就到这里吧。*/
}

- (void)beginLinesDemo:(CGContextRef)context
{
    //1.Line线
    
    CGContextSaveGState(context);
    cg_drawPentagramByLine(context, CGPointMake(150, 150), 100);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2);
    
//    CGMutablePathRef linePath = cg_drawLineByPath(CGPointZero, CGPointMake(100, 300));
//    CGContextAddPath(context, linePath);
//    cd_drawLines(context);
//    CGPathRelease(linePath);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}
- (void)beginArcsDemo:(CGContextRef)context
{
        //2.Arcs弧线
    CGContextSaveGState(context);
    cd_drawCircleByArc(context, CGPointMake(150, 150), 102);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2);
    
//    CGMutablePathRef arcPath = cd_drawArcsByPath(CGPointMake(100, 100), CGPointZero);
//    CGContextAddPath(context, arcPath);
//    CGPathRelease(arcPath);
    
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
}

- (void)beginCurvesDemo:(CGContextRef)context
{
    //3.Curve曲线
    CGContextSaveGState(context);
    cd_drawPinwheelByCurve(context,  CGPointMake(300, 100),  CGPointMake(0, 200),  CGPointMake(0, 0),  CGPointMake(300, 300));
    
    CGContextSetRGBFillColor(context, 246 / 255.0f, 122 / 255.0f , 180 / 255.0f, 0.6);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGMutablePathRef curvePath = cd_drawCurveByPath(CGPointMake(300, 200), CGPointMake(0, 100), CGPointMake(300, 0), CGPointMake(0, 300));
    CGContextAddPath(context, curvePath);
    CGPathRelease(curvePath);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}

- (void)beginEllipsesDemo:(CGContextRef)context
{
    //4.绘制椭圆
    CGContextSaveGState(context);
    cd_drawEllipses(context, CGRectMake(100, 50, 100, 200));
    
    CGMutablePathRef ellipsePath = cd_drawEllipsesByPath(CGRectMake(125, -125, 50, 100));
    CGContextAddPath(context, ellipsePath);
    CGPathRelease(ellipsePath);
    
    CGContextSetRGBFillColor(context, 146 / 255.0f, 162 / 255.0f , 244.0 / 255.0f, 0.6);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}

- (void)beginRectangleDemo:(CGContextRef)context
{
    //5.绘制长方形
    CGContextSaveGState(context);
    cd_drawRectangle(context, CGRectMake(200, 200, 10, 150));
//    cd_drawRectangles(context);
    CGMutablePathRef rectanglePath = cd_drawRectangleByPath(CGRectMake(100, 100, 100, 10));
    CGContextAddPath(context, rectanglePath);
    CGPathRelease(rectanglePath);
    
    CGContextSetRGBFillColor(context, 46 / 255.0f, 244 / 255.0f , 144.0 / 255.0f, 0.6);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}
@end









