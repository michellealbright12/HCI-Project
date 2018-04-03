//
//  UserInfo.h
//  HCI Project
//
//  Created by Ian Dieli on 4/2/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject {
    NSString *firstName;
    NSString *lastName;
    NSString *idNum;
}

- (id)initWithFirstName: (NSString *)fistName withLastName: (NSString *)lastName withIdNum: (NSString *)idNum;

-(NSString*)getFirstName;
-(NSString*)getLastName;
-(NSString*)getIdNum;

@end


