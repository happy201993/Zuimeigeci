//
//  ZuiMeiCollectionViewCell.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ZuiMeiCollectionViewCell.h"
#import "ZuiMeiTableViewCell.h"
#import "TopImageView.h"
#import "ZMTimeLineFrame.h"

NSString *const ZMTableCelldidSelectedNotification = @"ZMTableCelldidSelectedNotification";
static NSString *const reuseIdentifier = @"reuseidentifier";

@interface ZuiMeiCollectionViewCell() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) TopImageView *topImageView;

@end


@implementation ZuiMeiCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    
    return self;
}



#pragma mark - 创建子视图
- (void)createSubViews{
    
    //充满cell
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    [self.contentView addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    //注册cell
    [tableView registerClass:[ZuiMeiTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    //创建tableview的顶部视图
    TopImageView *topImageView = [[TopImageView alloc] initWithFrame:CGRectMake(0, 0, 0, ZMTopImageHeight)];
    self.topImageView = topImageView;
    tableView.tableHeaderView = topImageView;
    
}

#pragma mark - 重写set方法
- (void)setFaxianList:(NSArray *)faxianList
{
    _faxianList = faxianList;
    [self.tableView reloadData];
}
- (void)setSuiNianList:(NSArray *)suiNianList
{
    _suiNianList = suiNianList;
}

- (void)setHeaderModel:(HeaderViewModel *)headerModel
{
    _headerModel = headerModel;
    //设置数据
    self.topImageView.headerViewModel = headerModel;
}


#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.faxianList.count + self.suiNianList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZuiMeiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    NSInteger index = indexPath.row/2;
    ZMTimeLineFrame *frame = nil;
    if (indexPath.row % 2 == 0) {
        //浮游国
        frame = self.suiNianList[index];
    }else{
        //碎碎念
        frame = self.faxianList[index];
    }
    //设置数据
    cell.timeLineFrame = frame;
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row/2;
     ZMTimeLineFrame *frame = nil;
    if (indexPath.row % 2 == 0) {
        //文字
        frame = self.suiNianList[index];
    }else{
        //发现
        frame = self.faxianList[index];
    }
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row/2;
    ZMTimeLineFrame *frame = nil;
    if (indexPath.row % 2 == 0) {
        //文字
        frame = self.suiNianList[index];
    }else{
        //发现
        frame = self.faxianList[index];
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ZMTableCelldidSelectedNotification object:frame userInfo:nil];
}



@end
