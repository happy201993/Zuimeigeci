//
//  CommentTableView.m
//  zuimeigeci
//
//  Created by 小木木 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "CommentTableView.h"

static NSString *cellId = @"cellId";

@implementation CommentTableView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =  [super initWithFrame:frame style:style];
    if (self) {
        [self _createView];
            }
    return  self;
}


-(void)_createView{
    
    self.allowsSelection = NO;
    self.delegate = self;
    self.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]];
    [self registerNib:nib forCellReuseIdentifier:cellId];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commentArray.count;
}

-(NSInteger)numberOfSections{
    
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.commentArray[indexPath.row];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    faxianComment *model = self.commentArray[indexPath.row];
    
    return [CommentCell getCommentHeight:model];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //滑动时发送通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"resignNotification" object:self userInfo:nil];
}


@end
