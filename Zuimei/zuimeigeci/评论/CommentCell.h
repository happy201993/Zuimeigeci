//
//  CommentCell.h
//  zuimeigeci
//
//  Created by 小木木 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faxianComment.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic,strong) BmobObject *model;

+(float)getCommentHeight:(faxianComment *)model;
@end
