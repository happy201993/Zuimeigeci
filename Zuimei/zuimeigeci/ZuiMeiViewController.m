//
//  ZuiMeiViewController.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/2.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ZuiMeiViewController.h"
#import <Bmob.h>
#import "faxian.h"
#import "SuiSuiNian.h"
#import "HeaderViewModel.h"
#import "ZuiMeiCollectionViewCell.h"
#import "faxianComment.h"
#import "ZMTimeLineFrame.h"
#import "TopImageView.h"
#import "NSDate+Format.h"
#import "ZuiMeiTableViewCell.h"
#import "ZMFaxianDetailController.h"
#import "CommentViewController.h"



static NSString *const PERSONALSBNAME = @"Personal";
static NSInteger const QUERYCOUNT = 3;
static NSString *const reuseIdentifier = @"collectionviewcell";
@interface ZuiMeiViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray   *faxianList;
@property (nonatomic,strong) NSMutableArray   *suiNianList;
@property (nonatomic,strong) NSMutableArray   *headerList;

@property (nonatomic,assign) NSInteger        currentPage;

@property (nonatomic,weak  ) UICollectionView *mCollectionView;
@end

@implementation ZuiMeiViewController


#pragma mark - 生命周期的相关方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    [self fetchHeaderViewData];
    [self addZMObserver];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听通知
- (void)addZMObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticicationAction:) name:ZMShareActionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticicationAction:) name:ZMLikeActionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticicationAction:) name:ZMCommentActionNotification object:nil];
    
    //cell的点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticicationAction:) name:ZMTableCelldidSelectedNotification object:nil];
}

#if 0
- (void)test
{
    NSString *cls = NSStringFromClass([faxian class]);
    BmobQuery *query = [BmobQuery queryWithClassName:cls];
    [query orderByDescending:@"commentNum"];
    query.limit = 1;
    [query includeKey:@"author"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count != 0) {
            BmobObject *model = array[0];
            faxian *fx = [[faxian alloc] initFromBmobOjbect:model];
            
            BmobQuery *query2 = [BmobQuery queryWithClassName:NSStringFromClass([faxianComment class])];
            
            [query2 whereObjectKey:@"comment" relatedTo:fx];
            [query2 includeKey:@"author"];
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                for (BmobObject *obj in array) {
                    faxianComment *comment = [[faxianComment alloc] initFromBmobOjbect:obj];
                    
                    NSLog(@"%@",obj);
                }
                if (error) {
                    NSLog(@"error = %@",error);
                }
            }];
            
            
        }
        else
        {
            NSLog(@"%@",error);
        }
    }];
}
#endif

#pragma mark - 创建子视图
- (void)createSubViews{
    //设置布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    self.mCollectionView = collectionView;
    
    //设置代理
    collectionView.delegate = self;
    //设置数据源
    collectionView.dataSource = self;
    //注册cell
    [collectionView registerClass:[ZuiMeiCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:next];
    next.frame = CGRectMake(20, ZMScreenHeight - 50, 30, 30);
    [next addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *personalPage = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:personalPage];
    personalPage.frame = CGRectMake(ZMScreenWidth - 50,  ZMScreenHeight- 50, 30, 30);
    [personalPage addTarget:self action:@selector(peronButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)nextPage{
    _currentPage++;
    [self fetchHeaderViewData];
}
- (void)peronButtonAction{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:PERSONALSBNAME bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 数据懒加载
- (NSMutableArray *)faxianList
{
    if (_faxianList == nil) {
        _faxianList = [NSMutableArray array];
    }
    return _faxianList;
}
- (NSMutableArray *)suiNianList
{
    if (_suiNianList == nil) {
        _suiNianList = [NSMutableArray array];
    }
    return _suiNianList;
}
- (NSMutableArray *)headerList
{
    if (_headerList == nil) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

#pragma mark - 获取数据

- (void)fetchHeaderViewData{
    NSString *cls = NSStringFromClass([HeaderViewModel class]);
    BmobQuery *query = [BmobQuery queryWithClassName:cls];
    [query orderByDescending:@"createdAt"];
    query.limit = 1;
    [query setSkip:_currentPage];
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count != 0) {
            for (HeaderViewModel *model in array) {
                HeaderViewModel *headerModel = [[HeaderViewModel alloc] initFromBmobOjbect:model];
                [self.headerList addObject:headerModel];
            }
            [weakSelf fetchSuiNianData];
        }
        else
        {
            NSLog(@"%@",error);
        }
    }];
}


- (void)fetchSuiNianData{
    NSString *cls = NSStringFromClass([SuiSuiNian class]);
    BmobQuery *query = [BmobQuery queryWithClassName:cls];
    query.limit = QUERYCOUNT;
    [query setSkip:_currentPage * QUERYCOUNT];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
     __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count != 0) {
            for (SuiSuiNian *model in array) {
                SuiSuiNian *suiNian = [[SuiSuiNian alloc] initFromBmobOjbect:model];
                ZMTimeLineFrame *frame = [[ZMTimeLineFrame alloc] init];
                frame.object = suiNian;
                [self.suiNianList addObject:frame];
            }
            [weakSelf fetchFaxianData];
        }
        else
        {
            NSLog(@"%@",error);
        }
    }];
}

- (void)fetchFaxianData{
    
    NSString *cls = NSStringFromClass([faxian class]);
    BmobQuery *query = [BmobQuery queryWithClassName:cls];
    [query orderByDescending:@"createdAt"];
    query.limit = QUERYCOUNT;
    [query setSkip:_currentPage * QUERYCOUNT];
    [query includeKey:@"author"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count != 0) {
            for (faxian *model in array) {
                faxian *fx = [[faxian alloc] initFromBmobOjbect:model];
                ZMTimeLineFrame *frame = [[ZMTimeLineFrame alloc] init];
                frame.object = fx;
                [self.faxianList addObject:frame];
            }
            
            //加载完成
            [self.mCollectionView reloadData];
        }
        else
        {
            NSLog(@"%@",error);
        }
    }];
}


#pragma mark - CollectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.headerList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZuiMeiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.headerModel = self.headerList[indexPath.row];
    NSRange range = NSMakeRange(indexPath.row * QUERYCOUNT, QUERYCOUNT);
    NSArray *wenziList = [self.suiNianList subarrayWithRange:range];
    cell.suiNianList = wenziList;
    NSArray *faxianList = [self.faxianList subarrayWithRange:range];
    cell.faxianList = faxianList;
    return cell;
}

#pragma mark - CollectionView的代理方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.view.width;
    CGFloat height = 0;
    for (NSInteger i = 0 ; i < QUERYCOUNT; i++) {
        ZMTimeLineFrame *suinian = self.suiNianList[i];
        height += suinian.cellHeight;
        ZMTimeLineFrame *faxian = self.faxianList[i];
        height += faxian.cellHeight;
    }
    height += ZMTopImageHeight;
   
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(-20, 0, 0, 0);
}


#pragma mark - 通知相关方法处理
- (void)noticicationAction:(NSNotification *)notification{
    NSString *notificationName = notification.name;
    ZMTimeLineFrame *frameObj = notification.object;
    
    if ([notificationName isEqualToString:ZMShareActionNotification]) {
        NSLog(@"share");
    }else if ([notificationName isEqualToString:ZMLikeActionNotification]){
        NSLog(@"like");
    }else if ([notificationName isEqualToString:ZMCommentActionNotification]){
        NSLog(@"comment");
        CommentViewController *vc = [[CommentViewController alloc] init];
        vc.object = frameObj;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:navi animated:YES completion:nil];
    }else if ([notificationName isEqualToString:ZMTableCelldidSelectedNotification]){
        ZuiMeiTableViewCellStyle style = frameObj.style;
        if (style == ZuiMeiTableViewCellStyleWenzi) {
            NSLog(@"wenzi");
            
        }else if (style == ZuiMeiTableViewCellStyleFaxian){
            NSLog(@"faxian");
            ZMFaxianDetailController *vc = [[ZMFaxianDetailController alloc] init];
            vc.fxObject = (faxian *)frameObj.object;
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf presentViewController:navi animated:YES completion:nil];
            });
        }
    }
}

@end
