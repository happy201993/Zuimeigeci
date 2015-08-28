//
//  MySiteCollectionViewController.m
//  zuimeigeci
//
//  Created by Mee Leo on 27/8/2015.
//  Copyright © 2015 YCompany. All rights reserved.
//

#import "MySiteCollectionViewController.h"
@interface MySiteCollectionViewController ()

@end

@implementation MySiteCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CSStickyHeaderFlowLayout* layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        
        layout.parallaxHeaderReferenceSize = CGSizeMake(kScreenWidth, 300);
        
    }
    
    UINib* headerNib = [UINib nibWithNibName:@"MySiteHeaderViewController" bundle:nil];
    
    [self.collectionView registerNib:headerNib
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"header"];
    

    
    
    
    
    UINib* cellNib = [UINib nibWithNibName:@"MySiteCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib
          forCellWithReuseIdentifier:@"Cell"];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 1 ;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // Check the kind if it's CSStickyHeaderParallaxHeader
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"header"
                                                                                   forIndexPath:indexPath];
        
        return cell;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        
        
        // Your code to configure your section header...
    } else {
        // other custom supplementary views
    }
    return nil;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        
//        CSSectionHeader *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                   withReuseIdentifier:@"header"
//                                                                          forIndexPath:indexPath];
//        
//        return cell;
//        
//    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
//        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                            withReuseIdentifier:@"header"
//                                                                                   forIndexPath:indexPath];
//        
//        return cell;
//    }
//    return nil;
//}
#pragma mark <UICollectionViewDelegate>

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
