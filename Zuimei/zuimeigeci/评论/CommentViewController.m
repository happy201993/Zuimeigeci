//
//  CommentViewController.m
//  zuimeigeci
//
//  Created by 小木木 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableView.h"
#import "UIViewExt.h"

#import <BmobQuery.h>
#import "faxian.h"
#import "faxianComment.h"
#import "SuiSuiNian.h"
#import "wenziComment.h"
#import <MJRefresh.h>
#import "MBProgressHUD+MJ.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define kBottomBarH 49
#define kMargin 10
#define kHeadImageW (kBottomBarH - kMargin)

#define  kHeight [UIScreen mainScreen].bounds.size.height
#define  kWidth [UIScreen mainScreen].bounds.size.width



@interface CommentViewController (){
    
    CommentTableView *_tableView;
    UIView *_editorView;
    UITextView *_textView;
    UILabel *_label;
    UIButton *sendBtn;
    NSMutableArray *array1;
    MBProgressHUD *Hud;
    NSMutableArray *imageArray;
    User *user;
    
}

@end

@implementation CommentViewController


- (void)dealloc
{
    //从通知中心移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"评论";

        //接受table滑动时发送的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillQuit:) name:@"resignNotification" object:nil];
        
       //键盘改变时发送通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    user = [User getCurrentUser];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction:)];
    [self _createTableView];
    [self _createEditorViews];
    
    [self _loadData];
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    Hud = [MBProgressHUD showMessage:@"正在加载"];
    Hud.dimBackground = YES;
    _tableView.hidden = YES;
}

- (void)dismissAction:(UIBarButtonItem *)item{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)_loadData{
 
    imageArray = [[NSMutableArray alloc] init];
    BmobObject *obj = self.object.object;
    NSString *cls = nil;
    if (self.object.style == ZuiMeiTableViewCellStyleWenzi) {
        cls = NSStringFromClass([wenziComment class]);
    }else{
        cls = NSStringFromClass([faxianComment class]);
    }
    array1 = [[NSMutableArray alloc] init];
    BmobQuery *query2 = [BmobQuery queryWithClassName:cls];
    [query2 whereObjectKey:@"comment" relatedTo:obj];
    [query2 includeKey:@"author"];
    [query2 orderByDescending:@"updatedAt"];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        _tableView.hidden = NO;
        [Hud hide:YES];
        for(BmobObject *obj in array){
            BmobObject *comment = nil;
            if ([cls isEqualToString:NSStringFromClass([faxianComment class])]) {
                comment = [[faxianComment alloc] initFromBmobOjbect:obj];
            }
            else
            {
                comment = [[wenziComment alloc] initFromBmobOjbect:obj];
            }
            [array1 addObject:comment];
        }if (error) {
            NSLog(@"error = %@",error);
        }
        
        _tableView.commentArray = array1;
        [_tableView reloadData];
        [_tableView.header endRefreshing];
    }];


    
    
 
}


-(void)_createTableView{
    
    _tableView = [[CommentTableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - kBottomBarH)];
    [self.view addSubview:_tableView];
    
    //点击空白区域，键盘隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
    [_tableView addGestureRecognizer:tap];
    
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadData)];
    
}



-(void)_createEditorViews{
    
    _editorView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight-kBottomBarH, kWidth, kBottomBarH)];
    _editorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin  , kMargin/2, kHeadImageW, kHeadImageW)];
    UIImage *defImage = [UIImage imageNamed:@"avatar_def"];
    if (user != nil) {
        [headImage sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:defImage];
    }else
        headImage.image = defImage;
    [_editorView addSubview:headImage];
    
    CGFloat imageW = 35;
    sendBtn = [[UIButton alloc] initWithFrame: CGRectMake(kWidth-imageW - kMargin, (kBottomBarH - imageW)/2, imageW, imageW)];
    
    [sendBtn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setImage:[UIImage imageNamed:@"chat_send_n"] forState:UIControlStateNormal];
     [sendBtn setImage:[UIImage imageNamed:@"chat_send_p"] forState:UIControlStateHighlighted];
    [_editorView addSubview:sendBtn];
    CGFloat textViewX = CGRectGetMaxX(headImage.frame) + kMargin;
    CGFloat textViweW = CGRectGetMinX(sendBtn.frame) - CGRectGetMaxX(headImage.frame) - 2 *kMargin;
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(textViewX, kMargin/2, textViweW, kHeadImageW)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    _textView.layer.borderWidth = 1.5;
    _textView.layer.cornerRadius =5.0;
    _textView.delegate = self;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, -2, kWidth-120, 44)];

     _label.text = @"在这里说点什么吧";
    
    _label.enabled = NO;
    
    [_textView addSubview:_label];
    
    [_editorView addSubview:_textView];
    

    [self.view addSubview:_editorView];
    
    
}



//滑动时，键盘隐藏
-(void)keyBoardWillQuit:(NSNotification *)notification{
   
    [_textView resignFirstResponder];
}
//单击时键盘隐藏
-(void)Tap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    
}

//发送
-(void)send:(UIButton *)btn{
    NSLog(@"发送");
    if(_textView.text.length == 0) return;
    MBProgressHUD *HUD = [MBProgressHUD showMessage:@"发送中"];
    
    BmobUser *author = [BmobUser getCurrentUser];
    if (author != nil) {
        NSString *commentCls = nil;
        NSString *cls = nil;
        if (self.object.style == ZuiMeiTableViewCellStyleWenzi) {
            commentCls = NSStringFromClass([wenziComment class]);
            cls = NSStringFromClass([SuiSuiNian class]);
        }
        else{
            commentCls = NSStringFromClass([faxianComment class]);
            cls = NSStringFromClass([faxian class]);
        }
        BmobObject *comment = [BmobObject objectWithClassName:commentCls];
        [comment setObject:_textView.text forKey:@"content"];
        
        [comment setObject:author forKey:@"author"];
        
        //发现
        BmobObject *faxian = [BmobObject objectWithoutDatatWithClassName:cls objectId:self.object.object.objectId];
        NSString *key = (self.object.style == ZuiMeiTableViewCellStyleWenzi)?@"suisuinian":@"faxian";
        [comment setObject:faxian forKey:key];
        
        [comment saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                
                //添加关联关系
                BmobRelation *relation = [[BmobRelation alloc] init];
                [relation addObject:comment];
                
                [faxian addRelation:relation forKey:@"comment"];
                
                [faxian  updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    [HUD hide:YES];
                    if (isSuccessful) {
                        NSLog(@"successful");
                        
                        [MBProgressHUD showSuccess:@"✅发送成功"];
                        
                        [self.view endEditing:YES];
                        [self _loadData];
                        
                    }else{
                        NSLog(@"error %@",[error description]);
                        [MBProgressHUD showError:@"❌发送失败"];
                    }
                }];
                
            }else if (error){
                NSLog(@"%@",error);
                [MBProgressHUD showError:@"❌发送失败"];
            }else{
                NSLog(@"Unknow error");
                [MBProgressHUD showError:@"❌发送失败"];
            }
        }];
    }else{
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    _textView.text = nil;
    [self editorViewConditionNO];
}


#pragma mark - TextView 代理
-(void)textViewDidChange:(UITextView *)textView{
    
    NSString *str = _textView.text;
    BOOL isNil = [self isBlankString:str];
    if (isNil) {
        [self editorViewConditionNO];

    }else{
        [self editorViewConditionYES];
    }

}

//editorView不激活状态
-(void)editorViewConditionNO{
    
    [sendBtn setImage:[UIImage imageNamed:@"chat_send_n.png"] forState:UIControlStateNormal];
    sendBtn.enabled = NO;
    _label.hidden = NO;
}

//点击return 隐藏键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"空格");
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//editorView激活状态
-(void)editorViewConditionYES{
    [sendBtn setImage:[UIImage imageNamed:@"chat_send_n.png"] forState:UIControlStateNormal];
    sendBtn.enabled = YES;
    _label.hidden = YES;
}


#pragma mark - 键盘弹出通知

-(void)keyBoardWillChange:(NSNotification *)notification{
    
    //1 取出键盘frame
    NSValue *boundsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect frame = [boundsValue CGRectValue];
    
    //3 调整视图高度
   _editorView.bottom = frame.origin.y;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

//判断字符串是否为空
- (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
   
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
         return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
         return YES;
    }
    
    return NO;
}

@end
