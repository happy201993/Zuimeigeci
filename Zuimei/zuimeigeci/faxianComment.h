//
//  faxianComment.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "User.h"
#import "faxian.h"
@interface faxianComment : BmobObject


//private User author;
//private BmobFile ImageFile;
//private String content;
//private faxian faxian;

@property (nonatomic,strong) User *author;

@property (nonatomic,strong) BmobFile *ImageFile;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,strong) faxian *faxian;

@end
