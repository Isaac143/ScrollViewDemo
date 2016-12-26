//
//  CustemScrollView.m
//  ISAACScrollViewDemo
//
//  Created by Isaac on 16/12/25.
//  Copyright © 2016年 Isaac. All rights reserved.
//

#import "CustemScrollView.h"
#import "CollectionViewCell.h"

@interface CustemScrollView()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *bannerImgArray;

@property (nonatomic)BOOL isURL;

@end

@implementation CustemScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
    }
    return  self;
    
}

- (instancetype)initWithFrame:(CGRect)frame ImageArr:(NSArray *)imageArray {
    if ([super initWithFrame:frame]) {
        self.bannerImgArray = imageArray;
        id image = imageArray[0];
        _isURL = [image isKindOfClass:[UIImage class]] == YES ?  NO : YES;
        
        [self addTimer];
        
        [self createUI];
        
        self.backgroundColor = [UIColor greenColor];
        
    }
    return  self;
    
    
}
- (void)addTimer {
    if (_bannerImgArray.count > 1) {
        if (_pictureTimer == nil) {
            self.pictureTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
            [[NSRunLoop  mainRunLoop]addTimer:_pictureTimer forMode:NSRunLoopCommonModes];
        }else {
            [_pictureTimer fire];
        }
        
    }
}
- (void)nextPage {
    if (_bannerImgArray.count > 0) {
        NSIndexPath * currentTndexPath = [[self.secondCollectionView indexPathsForVisibleItems]lastObject];
        
        NSIndexPath * currentTndexPathReset = [NSIndexPath  indexPathForItem:currentTndexPath.item inSection:50];
        [self.secondCollectionView  scrollToItemAtIndexPath:currentTndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        NSInteger nextItem = currentTndexPathReset.item+1;
        NSInteger nextSection = currentTndexPathReset.section;
        if (nextItem==self.bannerImgArray.count) {
            nextItem=0;
            nextSection++;
        }
        
        NSIndexPath * nextIndexPath = [NSIndexPath  indexPathForItem:nextItem inSection:nextSection];
        [self.secondCollectionView  scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)createUI {
    
    self.superview.inputViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout * flowOut = [[UICollectionViewFlowLayout alloc]init];
    flowOut.minimumLineSpacing = 0;
    flowOut.minimumInteritemSpacing = 0;
    flowOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowOut.itemSize = CGSizeMake(ScreenWidth, 180);
    self.secondCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180) collectionViewLayout:flowOut];
    _secondCollectionView.pagingEnabled = YES;
    _secondCollectionView.bounces = NO;
    _secondCollectionView.delegate = self;
    _secondCollectionView.dataSource =self;
    _secondCollectionView.backgroundColor = [UIColor yellowColor];
    _secondCollectionView.showsHorizontalScrollIndicator=NO;
    [_secondCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"secondCell"];
    [self addSubview:self.secondCollectionView];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    _secondCollectionView.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height -20);
//}

#pragma mark CollectionView DataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _bannerImgArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.secondCollectionView){
        CollectionViewCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"secondCell" forIndexPath:indexPath];
        if (_isURL == YES) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[_bannerImgArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"banner_placeHolder.jpg"]];
        }else
           cell.imageView.image = _bannerImgArray[indexPath.row];
        
        cell.imageView.userInteractionEnabled = YES;
        return cell;
        
    }
    
    return nil;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.popBlock) {
        self.popBlock(_bannerImgArray[indexPath.row]);
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 100;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth, 180);
}

#pragma mark -- ScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == _secondCollectionView) {
        [self.pictureTimer invalidate];
        self.pictureTimer =nil;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _secondCollectionView) {
        if (_bannerImgArray.count > 1) {
            [self addTimer];
        }
    }
    
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView==_secondCollectionView) {
//        int page = (int)(scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width+0.5)%self.bannerImgArray.count;
////        self.pageControl.currentPage = page;
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
