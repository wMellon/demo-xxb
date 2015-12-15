//
//  NSString+Common.m
//  demo-xxb
//
//  Created by xxb on 15/12/15.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

#pragma mark - 判断是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
