//
//  CollectionViewCell.m
//  SmallRichMan
//
//  Created by zhu on 16/3/31.
//  Copyright © 2016年 小财主. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,  180)];
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
