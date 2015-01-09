//
//  LoginService.h
//  BDDViewControllersDB
//
//  Created by Stefan Claussen on 09/01/2015.
//  Copyright (c) 2015 One foot after the other. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginService : NSObject

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void(^)(BOOL success))completion;

@end
