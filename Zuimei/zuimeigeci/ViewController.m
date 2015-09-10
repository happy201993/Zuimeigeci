//
//  ViewController.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/16.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import <BmobSDK/BmobQuery.h>
#import "HeaderViewModel.h"
#import "TopImageView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet TopImageView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testQuery];
    
}

- (void)testQuery
{
    NSString *cls = NSStringFromClass([HeaderViewModel class]);
    BmobQuery *query = [BmobQuery queryWithClassName:cls];
    query.limit = 5;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        if (array.count != 0) {
            for (HeaderViewModel *model in array) {
                NSLog(@"%@",model);
            }
            
            HeaderViewModel *obj = array[3];
            HeaderViewModel *model = [[HeaderViewModel alloc] initFromBmobOjbect:obj];
             self.headerView.headerViewModel = model;
        }
        else
        {
            NSLog(@"%@",error);
        }
    }];
    
}


- (void)testUser
{
    User *user = (User *)[User getCurrentUser];
    if (user == nil) {
        [User loginWithUsernameInBackground:@"15757176639" password:@"123" block:^(BmobUser *user, NSError *error) {
            
        }];
    }
    
    NSLog(@"user = %@",user);
}

@end
