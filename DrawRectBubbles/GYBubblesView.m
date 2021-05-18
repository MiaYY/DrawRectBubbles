//
//  GYBubblesView.m
//  DrawRectBubbles
//
//  Created by MOON on 2021/2/22.
//

#import "GYBubblesView.h"
#import "Masonry.h"

#define kPopupTriangleHeigh 5
#define kPopupTriangleWidth 6
#define kPopupTriangleTopPointX 3 * (self.frame.size.width - kPopupTriangleWidth)/ 20.0f
#define kBorderOffset       0//0.5f

@implementation GYBubblesView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    //view的 width  85    height  121
    self.labelTitle = UILabel.new;
    self.labelTitle.text = @"你可能要发送的照片:";
    self.labelTitle.numberOfLines = 2;
    self.labelTitle.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:self.labelTitle];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labelTitle.superview).offset(6);
        make.top.mas_equalTo(self.labelTitle.superview).offset(5);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(30);
    }];
    
    self.imageViewRecently = UIImageView.new;
    self.imageViewRecently.clipsToBounds = YES;
    self.imageViewRecently.layer.cornerRadius = 4.8;
    self.imageViewRecently.backgroundColor = [UIColor redColor];
    [self addSubview:self.imageViewRecently];
    [self.imageViewRecently mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labelTitle);
        make.top.mas_equalTo(self.labelTitle.mas_bottom).offset(6);
        make.size.mas_equalTo(75);
    }];
}

//给view绘制边框，成气泡形状
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat viewW = rect.size.width;//85
    CGFloat viewH = rect.size.height;//121+6
    CGFloat strokeWidth = 0.2;
    CGFloat borderRadius = 5;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(context, kCGLineJoinRound); //
    CGContextSetLineWidth(context, strokeWidth); // 画笔宽度
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor); // 画笔颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // 填充颜色
    //箭头在右下
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, viewW - 10, viewH - 6);
    CGContextAddLineToPoint(context, viewW - 10 - 4, viewH - 6);//左边横线
    CGContextAddLineToPoint(context, viewW - 10 - 7, viewH - strokeWidth);//左边斜线
    CGContextAddLineToPoint(context, viewW - 10 - 10, viewH - 6);//右边横线
    CGContextAddArcToPoint(context, strokeWidth, viewH - 6, strokeWidth, viewH - 6 - borderRadius, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth, strokeWidth, borderRadius+strokeWidth, strokeWidth, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, viewW-strokeWidth, strokeWidth, viewW-strokeWidth, borderRadius + strokeWidth, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, viewW-strokeWidth, viewH - 6, viewW-borderRadius-strokeWidth, viewH - 6, borderRadius-strokeWidth);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    //箭头在左上
//    CGFloat viewW = rect.size.width;//85
//    CGFloat viewH = rect.size.height;//121
//
//    CGFloat strokeWidth = 0.2;
//    CGFloat borderRadius = 5;
//    CGFloat offset = strokeWidth + kBorderOffset;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineJoin(context, kCGLineJoinRound); //
//    CGContextSetLineWidth(context, strokeWidth); // 设置画笔宽度
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 设置画笔颜色
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // 设置填充颜色
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, borderRadius+offset, kPopupTriangleHeigh + offset);
//    CGContextAddLineToPoint(context, kPopupTriangleTopPointX - kPopupTriangleWidth / 2.0 + offset, kPopupTriangleHeigh + offset);
//    CGContextAddLineToPoint(context, kPopupTriangleTopPointX, offset);
//    CGContextAddLineToPoint(context, kPopupTriangleTopPointX + kPopupTriangleWidth / 2.0 +offset, kPopupTriangleHeigh + offset);
//
//    CGContextAddArcToPoint(context, viewW-offset, kPopupTriangleHeigh+offset, viewW-offset, kPopupTriangleHeigh+offset + borderRadius, borderRadius-strokeWidth);
//    CGContextAddArcToPoint(context, viewW-offset, viewH - offset, viewW-borderRadius-offset, viewH - offset, borderRadius-strokeWidth);
//    CGContextAddArcToPoint(context, offset, viewH - offset, offset, viewH - borderRadius - offset, borderRadius-strokeWidth);
//    CGContextAddArcToPoint(context, offset, kPopupTriangleHeigh + offset, viewW - borderRadius - offset, kPopupTriangleHeigh + offset, borderRadius-strokeWidth);
//
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
}

//绘制气泡
/**
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //这里可以设置你要在气泡view上显示的内容
        
    }
    return self;
    
}

//通过drawRect 画一个 带箭头的气泡框

- (void)drawRect:(CGRect)rect {
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [[UIColor clearColor] CGColor];
    
    self.layer.shadowOpacity = 1.0;
    
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

-(void)drawInContext:(CGContextRef)context{
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor);
    
    [self getDrawPath:context];
    
    CGContextFillPath(context);
    
}

-(void)getDrawPath:(CGContextRef)context{
    
    CGRect rrect = self.bounds;
    
    CGFloat radius = 20.0;
    
    CGFloat minx = CGRectGetMinX(rrect),
    
    midx = CGRectGetMidX(rrect),
    
    maxx = CGRectGetMaxX(rrect);
    
    CGFloat miny = CGRectGetMinY(rrect),
    
    maxy = CGRectGetMaxY(rrect)-10;
    
    CGContextMoveToPoint(context, midx+10, maxy);
    
    CGContextAddLineToPoint(context, midx, maxy+10);

    CGContextAddLineToPoint(context, midx-10, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    
    CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius);
    
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
    
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    
    CGContextClosePath(context);
    
}
*/

@end
