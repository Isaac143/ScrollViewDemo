//
//  CustemScrollView.h
//  ISAACScrollViewDemo
//
//  Created by Isaac on 16/12/25.
//  Copyright © 2016年 Isaac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustemScrollView : UIView

@property (nonatomic, strong)NSTimer *pictureTimer;
@property (nonatomic, strong)UICollectionView *secondCollectionView;
//@property (nonatomic, strong)UIView *headerVIEW;
//@property (nonatomic, strong)UIImageView *bannerBackImage;

- (instancetype)initWithFrame:(CGRect)frame ImageArr:(NSArray *)imageArray;


@end
