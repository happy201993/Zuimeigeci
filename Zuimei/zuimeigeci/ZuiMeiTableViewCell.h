//
//  ZuiMeiTableViewCell.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMTimeLineFrame.h"



extern  NSString *const ZMShareActionNotification;
extern  NSString *const ZMLikeActionNotification;
extern  NSString *const ZMCommentActionNotification;
@interface ZuiMeiTableViewCell : UITableViewCell

@property (nonatomic,strong) ZMTimeLineFrame *timeLineFrame;


@end
