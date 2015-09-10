//
//  FirstWelComePagesViewController.m
//  zuimeigeci
//
//  Created by Mee Leo on 8/9/2015.
//  Copyright © 2015 YCompany. All rights reserved.
//

#import "FirstWelComePagesViewController.h"

@interface FirstWelComePagesViewController ()

@end

@implementation FirstWelComePagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.welcomeScrollView.contentSize = CGSizeMake(ZMScreenWidth*3, ZMScreenHeight);
    
    self.welcomeScrollView.contentOffset = CGPointMake(0, 0);
    
    self.welcomeScrollView.pagingEnabled = YES;
    
    self.welcomeScrollView.showsVerticalScrollIndicator = NO;
    self.welcomeScrollView.showsHorizontalScrollIndicator = NO;
    
//    NSMutableArray* imageViewArray = [NSMutableArray array];
    for (int i = 0; i < 3;i++ ) {
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*ZMScreenWidth,0 , ZMScreenWidth, ZMScreenHeight)];
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.welcomeScrollView addSubview:imageView];
        
        
        
    }
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
