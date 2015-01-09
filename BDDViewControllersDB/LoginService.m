//
//  LoginService.m
//  BDDViewControllersDB
//
//  Created by Stefan Claussen on 09/01/2015.
//  Copyright (c) 2015 One foot after the other. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void(^)(BOOL success))completion
{
    completion([username isEqualToString:@"correct username"] && [password isEqualToString:@"correct password"]);
}

@end
