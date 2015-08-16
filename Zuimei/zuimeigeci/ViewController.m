//
//  ViewController.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/16.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = (User *)[User getCurrentUser];
    if (user == nil) {
        [User loginWithUsernameInBackground:@"15757176639" password:@"123" block:^(BmobUser *user, NSError *error) {
            
        }];
    }
    
    NSLog(@"user = %@",user);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
