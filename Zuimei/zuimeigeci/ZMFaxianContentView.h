//
//  ZMFaxianContentView.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/9.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faxian.h"
@interface ZMFaxianContentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextView *fxTextView;


@property (nonatomic,strong) faxian *fxObject;
@end
