//
//  NSString+Extension.h
//  Extension
//
//  Created by Soldier on 2016/12/15.
//  Copyright © 2016年 Shaojie Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (BOOL)isEmpty:(NSString *)str;

- (NSString *)md5Hash;

- (NSString *)urlEncode;

- (NSString *)urlDecode;

- (NSDictionary *)toDictionary;

- (NSMutableDictionary *)toMutableDictionary;

+ (NSString *)subString:(NSString *)str
                 length:(NSInteger)charIndex
                  trail:(BOOL)trail
          unitCharCount:(int)unitCharCount;

@end
