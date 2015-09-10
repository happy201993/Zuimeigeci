//
//  ZuiMeiCollectionViewCell.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeaderViewModel.h"
#import "faxian.h"
#import "SuiSuiNian.h"

extern NSString *const ZMTableCelldidSelectedNotification;

@interface ZuiMeiCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) HeaderViewModel *headerModel; //顶部模型

@property (nonatomic,strong) NSArray *suiNianList; //碎碎念

@property (nonatomic,strong) NSArray *faxianList;  //浮游国

@property (nonatomic,assign,readonly) CGFloat contentHeight;

@end
