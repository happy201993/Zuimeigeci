//
//  headerCell.m
//  zuimeigeci
//
//  Created by Mee Leo on 3/9/2015.
//  Copyright © 2015 YCompany. All rights reserved.
//

#import "headerCell.h"
#import "FXBlurView.h"
#import "NewSwimViewController.h"
#import "MySiteCollectionViewController.h"
#import "NewPiecesViewController.h"
@implementation headerCell

- (void)awakeFromNib {
    self.icon.layer.borderColor = [UIColor clearColor].CGColor;
//    self.icon.layer.borderWidth = 100.0f;
    self.icon.layer.masksToBounds = YES;
    [self addObserver:self forKeyPath:@"icon.bounds"options:NSKeyValueObservingOptionNew context:@"123"];
    
    
    // Initialization code
    
    
}

-(void)dealloc{
    
    [self removeObserver:self forKeyPath:@"icon.bounds"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
//    NSLog(@"%@",change[@"new"]);
//    NSLog(@"%f", self.icon.frame.size.width );
    CGRect new = [change[@"new"] CGRectValue];
  //  NSLog(@"%f",new.size.height);
//    self.icon.layer.borderColor = [UIColor clearColor].CGColor;
////        self.icon.layer.borderWidth = 100.0f;
//    self.icon.layer.masksToBounds = YES;
//    self.icon.layer.cornerRadius = new.size.height-50;
    self.fkBlurView.blurRadius = new.size.height/3.0;
}
- (IBAction)newSwim:(id)sender {
    
    
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    NewSwimViewController* newSWimVC = [storyBoard instantiateViewControllerWithIdentifier:@"NewSwim"];
    MySiteCollectionViewController* mySite = (id)self.nextResponder.nextResponder.nextResponder;
    [mySite.navigationController pushViewController:newSWimVC animated:YES];
    
    
}
- (IBAction)newPieces:(id)sender {
    
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    NewPiecesViewController* newPiecesVC = [storyBoard instantiateViewControllerWithIdentifier:@"NewPieces"];
    NewPiecesViewController* mySite = (id)self.nextResponder.nextResponder.nextResponder;
    [mySite.navigationController pushViewController:newPiecesVC animated:YES];
}

@end
