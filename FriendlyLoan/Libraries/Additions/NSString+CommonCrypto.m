//
//  NSString+CommonCrypto.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 29.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "NSString+CommonCrypto.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (CommonCrypto)

- (NSString *)SHA1String
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
    
}

- (NSString *)MD5String
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, strlen(cStr), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
}

@end
