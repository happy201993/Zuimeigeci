//
//  CommentTableView.h
//  zuimeigeci
//
//  Created by 小木木 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCell.h"
#import "faxianComment.h"

@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,copy)NSArray *commentArray;
@property (nonatomic,strong)NSArray *imageArray;

@end
