//
//  ViewController.m
//  ISAACScrollViewDemo
//
//  Created by Isaac on 16/12/25.
//  Copyright © 2016年 Isaac. All rights reserved.
//

#import "ViewController.h"
#import "CustemScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"无限滚动";
//    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initViews];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)initViews {
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d",i]];
        
        [imgArray addObject:image];
    }
    
    NSString *url1 = @"http://www.xiaocaizhu365.com/oss/file/20160926/201609261719270960894453.png";
    NSString *url2 = @"http://www.xiaocaizhu365.com/oss/file/20161118/201611181633502381098359.png";
    NSString *url3 = @"http://www.xiaocaizhu365.com/oss/file/20160924/201609241604145308952421.png";
    NSArray *imgArr = [NSArray arrayWithObjects:url1, url2, url3, nil];
    
    CustemScrollView *scrollView = [[CustemScrollView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 200) ImageArr:imgArr];  //[NSArray arrayWithArray:imgArray]
    
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
