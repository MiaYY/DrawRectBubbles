//
//  TestDrawView.m
//  DrawRectBubbles
//
//  Created by MOON on 2021/2/22.
//

#import "TestDrawView.h"
#define kPopupTriangleHeigh 5
#define kPopupTriangleWidth 6
#define kPopupTriangleTopPointX 3 * (self.frame.size.width - kPopupTriangleWidth)/ 20.0f
#define kBorderOffset       0//0.5f

@implementation TestDrawView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    
    CGFloat strokeWidth = 0.2;
    CGFloat borderRadius = 5;
    CGFloat offset = strokeWidth + kBorderOffset;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(context, kCGLineJoinRound); //
    CGContextSetLineWidth(context, strokeWidth); // 设置画笔宽度
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 设置画笔颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // 设置填充颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius+offset, kPopupTriangleHeigh + offset);
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX - kPopupTriangleWidth / 2.0 + offset, kPopupTriangleHeigh + offset);
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX, offset);
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX + kPopupTriangleWidth / 2.0 +offset, kPopupTriangleHeigh + offset);
    
    CGContextAddArcToPoint(context, viewW-offset, kPopupTriangleHeigh+offset, viewW-offset, kPopupTriangleHeigh+offset + borderRadius, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, viewW-offset, viewH - offset, viewW-borderRadius-offset, viewH - offset, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, offset, viewH - offset, offset, viewH - borderRadius - offset, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, offset, kPopupTriangleHeigh + offset, viewW - borderRadius - offset, kPopupTriangleHeigh + offset, borderRadius-strokeWidth);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
