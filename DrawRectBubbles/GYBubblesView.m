//
//  GYBubblesView.m
//  DrawRectBubbles
//
//  Created by MOON on 2021/2/22.
//

#import "GYBubblesView.h"
#import "Masonry.h"

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
    //view的 width  85    height  121+6
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
}

@end
