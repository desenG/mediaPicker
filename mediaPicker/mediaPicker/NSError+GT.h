//
//  NSError+GT.h
//  SmartConcrete
//
//  Created by giatec on 2016-11-17.
//  Copyright © 2016 Giatec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError(GT)
+ (NSError *)httpError;
+ (NSError *)networkError;
+ (NSError *)unexpectedError;
@end
