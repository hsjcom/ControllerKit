//
//  NSString+Extension.m
//  Extension
//
//  Created by Soldier on 2016/12/15.
//  Copyright © 2016年 Shaojie Hong. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

+ (BOOL)isEmpty:(NSString *)str {
    if(str == nil || [str length] == 0 || [str isKindOfClass:[NSNull class]]){
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSString *)md5Hash {
    if([self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [NSString stringWithString:outputString];
}

- (NSString *)urlEncode{
    return [[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
}

- (NSString *)urlDecode{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSDictionary *)toDictionary{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    if (!jsonData) {
        return nil;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if(error) {
        return nil;
    }
    return dic;
}

- (NSMutableDictionary *)toMutableDictionary{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    if (!jsonData) {
        return nil;
    }
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    return dic;
}

+ (NSString *)subString:(NSString *)str length:(NSInteger)charIndex trail:(BOOL)trail unitCharCount:(int)unitCharCount {
    int count = 0;
    if ([NSString isEmpty:str]) {
        return nil;
    }
    NSString *subStr = str;
    for (int i = 0; i < [str length]; i++) {
        unichar c = [str characterAtIndex:(NSUInteger) i];
        if (isblank(c) || isascii(c)) {
            count++;
        } else {
            count += unitCharCount;
        }
        if (count >= charIndex) {
            if (trail) {
                subStr = [NSString stringWithFormat:@"%@...", [str substringToIndex:(NSUInteger) i]];
            } else {
                subStr = [str substringToIndex:(NSUInteger) i];
            }
            break;
        }
    }
    return subStr;
}


@end
