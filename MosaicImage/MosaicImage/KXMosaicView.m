//
//  KXMosaicView.m
//  MosaicImage
//
//  Created by FD on 2018/3/15.
//  Copyright © 2018年 FD. All rights reserved.
//

#import "KXMosaicView.h"
@interface KXMosaicView()
//存放顶层图片的UIImageView，图片为正常的图片
@property (nonatomic, strong) UIImageView *topImageView;

//展示马赛克图片的涂层
@property (nonatomic, strong) CALayer *mosaicImageLayer;

//遮罩层，用于设置形状路径
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

//手指涂抹的路径
@property (nonatomic, assign) CGMutablePathRef path;
@end

@implementation KXMosaicView

- (void)dealloc{
    if (self.path) {
        CGPathRelease(self.path);
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化顶层图片视图
        self.topImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.topImageView];
        
        //初始化马赛克图层
        self.mosaicImageLayer = [CALayer layer];
        self.mosaicImageLayer.frame  = self.bounds;
        [self.layer addSublayer:self.mosaicImageLayer];
        
        //初始化遮罩图层
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.frame = self.bounds;
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.lineJoin = kCALineJoinRound;
        self.shapeLayer.lineWidth = 10.0f;
        self.shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
        self.shapeLayer.fillColor = nil;
        [self.layer addSublayer:self.shapeLayer];
        
        //设置当前的马赛克图层的遮罩层
        self.mosaicImageLayer.mask = self.shapeLayer;
        self.path = CGPathCreateMutable();
    }
    return self;
}

- (void)setOriginalImage:(UIImage *)originalImage{
    _originalImage  = originalImage;//原始图片
    self.topImageView.image = originalImage;//顶层视图展示原始图片
}

- (void)setMosaicImage:(UIImage *)mosaicImage{
    _mosaicImage = mosaicImage;//马赛克图片
    self.mosaicImageLayer.contents = (__bridge id _Nullable)([mosaicImage CGImage]);//将马赛克图层内容设置为马赛克图片内容
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPathMoveToPoint(self.path, NULL, point.x, point.y);
    CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
    self.shapeLayer.path = path;
    CGPathRelease(path);
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
    CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
    self.shapeLayer.path = path;
    CGPathRelease(path);
    
}


@end
