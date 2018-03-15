//
//  KXMosaicView.h
//  MosaicImage
//
//  Created by FD on 2018/3/15.
//  Copyright © 2018年 FD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KXMosaicView : UIView
//底图为马赛克图
@property (nonatomic, strong) UIImage *mosaicImage;
//表图为正常图片
@property (nonatomic, strong) UIImage *originalImage;
@end
