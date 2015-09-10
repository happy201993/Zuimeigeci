//
//  headerCell.h
//  zuimeigeci
//
//  Created by Mee Leo on 3/9/2015.
//  Copyright © 2015 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
@interface headerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIcon;
@property (weak, nonatomic) IBOutlet FXBlurView *fkBlurView;

@end
