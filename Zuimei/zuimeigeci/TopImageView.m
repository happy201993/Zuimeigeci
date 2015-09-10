//
//  TopImageView.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "TopImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+YExtension.h"
#define ZMPadding 10
#define ZMTextFont [UIFont systemFontOfSize:16]
@implementation TopImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        frame.size.height = ZMTopImageHeight;
        self.frame = frame;
       
        [self createSubViews];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self createSubViews];
}

- (void)createSubViews
{
    //图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    //文字
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    self.text = label;
    label.textColor = [UIColor whiteColor];
    label.font = ZMTextFont;
    
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
}


- (void)setHeaderViewModel:(HeaderViewModel *)headerViewModel
{
    _headerViewModel = headerViewModel;
    //设置数据
    [self setData];
    //设置子视图的frame
    [self setSubViewFrame];
    
}

- (void)setData{
    self.text.text = self.headerViewModel.headerText;
    NSURL *imageUrl = [NSURL URLWithString:self.headerViewModel.headerImage];
    UIImage *placeholderImage = [UIImage imageNamed:ZMPlaceHolderImageName];
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:placeholderImage];
    
}

- (void)setSubViewFrame{
    //计算frame
    
    CGFloat frameW = self.frame.size.width;
    CGFloat frameH = self.frame.size.height;
   
    //imageview 填充整个view
    self.imageView.frame = self.bounds;
    
    //计算text的frame
    CGFloat maxW = frameW - 2 * ZMPadding;
    CGFloat maxH = frameH;
    CGSize maxSize = CGSizeMake(maxW, maxH);
    CGSize textArea = [self.text.text sizeWithFont:ZMTextFont withMaxSize:maxSize];
    
    CGFloat textW = textArea.width;
    CGFloat textH = textArea.height;
    CGFloat textX = ZMPadding;
    CGFloat textY = frameH - textH - ZMPadding;
    self.text.frame = CGRectMake(textX, textY, textW, textH);
}




@end
