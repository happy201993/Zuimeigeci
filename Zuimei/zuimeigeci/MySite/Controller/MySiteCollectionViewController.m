//
//  MySiteCollectionViewController.m
//  zuimeigeci
//
//  Created by Mee Leo on 3/9/2015.
//  Copyright © 2015 YCompany. All rights reserved.
//

#import "MySiteCollectionViewController.h"
#import <CSStickyHeaderFlowLayout.h>
#import "headerCell.h"
#import "mainCell.h"
#import "SectionHeaderCell.h"
#import <BmobSDK/Bmob.h>
@interface MySiteCollectionViewController ()
@property (nonatomic, strong) UINib *headerNib;
@property (nonatomic, strong) NSArray *sections;

@end

@implementation MySiteCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.sections = @[
                          @[
                              @"Song 1",
                              @"Song 2",
                              @"Song 3",
                              @"Song 4",
                              @"Song 5",
                              @"Song 6",
                              @"Song 7",
                              @"Song 8",
                              @"Song 9",
                              @"Song 10",
                              @"Song 11",
                              @"Song 12",
                              @"Song 13",
                              @"Song 14",
                              @"Song 15",
                              @"Song 16",
                              @"Song 17",
                              @"Song 18",
                              @"Song 19",
                              @"Song 20",
                              ],
                          ];

        
        self.headerNib = [UINib nibWithNibName:@"headerCell" bundle:nil];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [BmobUser loginWithUsernameInBackground:@"15757176639" password:@"123" block:^(BmobUser *user, NSError *error) {
       
        if (error) {
            NSLog(@"%@",error);
        }else{
            
            NSLog(@"%@",user);
        }
        
        
    }];
    
    [self reloadLayout];
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    [self.collectionView registerNib:self.headerNib forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:@"header"];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self reloadLayout];
}

- (void)reloadLayout{
    
    CSStickyHeaderFlowLayout* layout = (id)self.collectionViewLayout;
    
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 426);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 110);
        layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
        layout.parallaxHeaderAlwaysOnTop = YES;
        
        // If we want to disable the sticky header effect
        layout.disableStickyHeaders = YES;
        
    }
    


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sections count];

    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
- (IBAction)settingAction:(id)sender {
    
    UIStoryboard* settingStoryBoard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    UITableViewController* settingVC = [ settingStoryBoard instantiateViewControllerWithIdentifier:@"MainSetting"];
    [self.navigationController pushViewController:settingVC animated:YES];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *obj = self.sections[indexPath.section][indexPath.row];
    
    mainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                               forIndexPath:indexPath];
    
    cell.textLabel.text = obj;

    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
     SectionHeaderCell   *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                   withReuseIdentifier:@"sectionHeader"
                                                                          forIndexPath:indexPath];
        
        return cell;
        
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"header"
                                                                                   forIndexPath:indexPath];
        
        return cell;
    }
    return nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
