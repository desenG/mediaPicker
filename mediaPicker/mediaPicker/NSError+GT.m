//
//  NSError+GT.m
//  SmartConcrete
//
//  Created by giatec on 2016-11-17.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import "NSError+GT.h"

@implementation NSError(GT)
+ (NSError *)httpError {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:@"Some problems with your request. Please try again later." forKey:NSLocalizedDescriptionKey];//FIXME: add localized string.
    return [NSError errorWithDomain:@"httpError" code:1024 userInfo:userInfo];
}
+ (NSError *)networkError {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:@"Some problems with connection to network. Please try again later." forKey:NSLocalizedDescriptionKey];//FIXME: add localized string.
    return [NSError errorWithDomain:@"networkError" code:1025 userInfo:userInfo];
}
+ (NSError *)unexpectedError {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:@"Some unexpected problems occured. Please try again later." forKey:NSLocalizedDescriptionKey];//FIXME: add localized string.
    return [NSError errorWithDomain:@"unexpectedError" code:1026 userInfo:userInfo];
}
@end
