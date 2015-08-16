//
//  main.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/16.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appKey = @"23eb9fba070802306ddb25ee29760a04";
        [Bmob registerWithAppKey:appKey];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
