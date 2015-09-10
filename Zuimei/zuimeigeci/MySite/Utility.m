//
//  Utility.m
//  zuimeigeci
//
//  Created by Mee Leo on 4/9/2015.
//  Copyright © 2015 YCompany. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(User *)getCurrentUserModel{
 
//    BmobObject* userObject = (BmobObject*)[BmobUser getCurrentUser];
//    NSDictionary* userDict = [userObject objectForKey:@"userDic"];
    User* user = (User *)[User getCurrentUser];
    
//    [user setValuesForKeysWithDictionary:userDict];
    
    return user;
    
    
}

@end
