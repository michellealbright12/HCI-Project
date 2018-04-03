//
//  UserInfo.m
//  HCI Project
//
//  Created by Ian Dieli on 4/2/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (id)initWithFirstName: (NSString *)fistName withLastName: (NSString *)lastName withIdNum: (NSString *)idNum {
    
    if ((self = [super init])) {
        self->firstName = fistName;
        self->lastName = lastName;
        self->idNum = idNum;
    }
    
    return self;
}

-(NSString*)getFirstName; {
    return firstName;
}

-(NSString*)getLastName; {
    return lastName;
}

-(NSString*)getIdNum; {
    return idNum;
}

@end

