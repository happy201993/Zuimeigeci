//
//  CommentCell.m
//  zuimeigeci
//
//  Created by 小木木 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "CommentCell.h"
#import "UIViewExt.h"

#import "UIImageView+WebCache.h"

typedef NS_ENUM(NSUInteger, ZMCommentType) {
    ZMCommentTypeWenzi,
    ZMCommentTypeFaxian,
};

@implementation CommentCell{
    UILabel *_commentLabel;
    UIImage *image;
    ZMCommentType type;
}

- (void)awakeFromNib {
    
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    _commentLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_commentLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(BmobObject *)model
{
    _model = model;
    if ([model isKindOfClass:[faxianComment class]]) {
        type = ZMCommentTypeFaxian;
    }else{
        type = ZMCommentTypeWenzi;
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
     faxianComment *comment = (faxianComment *)self.model;
  
    NSString *str = comment.author.avatar;
    UIImage *defImg = [UIImage imageNamed:@"avatar_def.png"];
    if(str){
       [_headImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:defImg];
    }else{
        
       _headImage.image = defImg;
    }

    _userName.text = comment.author.nick;
    
    _commentLabel.text = comment.content;
    
    
   CGSize size = [self boundingRectWithLabel:_commentLabel WithSize:CGSizeMake(ZMScreenWidth-100, ZMScreenHeight)];
    
    _commentLabel.frame = CGRectMake(_headImage.right+15, _userName.bottom+20, size.width,size.height);
    _commentLabel.numberOfLines = 0;
    

    //设置_date.text
    NSDate *date = self.model.createdAt;
    NSTimeInterval interval = -date.timeIntervalSinceNow;
    int years = (int)(interval)/(3600*24*365);
    
    if(years > 0){
        _date.text = [NSString stringWithFormat:@"%d年前",years];
        
        return;
    }else{
        int months = (int)(interval)/(3600*24*30);
        if(months >0){
            _date.text = [NSString stringWithFormat:@"%d个月前",months];
            return;
        }else{
            int days=(int)(interval)/(3600*24);
            if(days >0){
                _date.text = [NSString stringWithFormat:@"%d天前",days];
                return;
            }else{
                int hour = (int)(interval/3600);
                if(hour >0){
                    _date.text = [NSString stringWithFormat:@"%d小时前",hour];
                    return;
                }else{
                    
                    int minute = (int)(interval - hour*3600)/60;
                    if(minute >0){
                        _date.text = [NSString stringWithFormat:@"%d分钟前",minute];
                    }else{
                        _date.text = [NSString stringWithFormat:@"刚刚"];
                    }
                }
            }
        }
    }
}

- (CGSize)boundingRectWithLabel:(UILabel *)Label WithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    
    CGSize retSize = [Label.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

+(float)getCommentHeight:(faxianComment *)model{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = model.content;
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize size = CGSizeMake(ZMScreenWidth-100, ZMScreenHeight);
    CGSize retSize = [label.text boundingRectWithSize:size
                                              options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                           attributes:attribute
                                              context:nil].size;
    return retSize.height+70;
    
}


@end
