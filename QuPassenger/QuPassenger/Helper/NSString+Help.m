//
//  NSString+Help.m
//  FreshFood
//
//  Created by 朱青 on 2017/7/17.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import "NSString+Help.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>



@implementation NSData (base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    const char lookup[] = {
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,  99,  99,  99, 99,
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,  99,  99,  99, 99,
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 62,  99,  99,  99, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 99, 99,  99,  99,  99, 99,
        99, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12,  13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 99,  99,  99,  99, 99,
        99, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38,  39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 99,  99,  99,  99, 99
    };
    
    NSData *inputData = [string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    long long inputLength = [inputData length];
    const unsigned char *inputBytes = [inputData bytes];
    
    long long maxOutputLength = (inputLength / 4 + 1) * 3;
    NSMutableData *outputData = [NSMutableData dataWithLength:(NSUInteger)maxOutputLength];
    unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];
    
    int accumulator = 0;
    long long outputLength = 0;
    unsigned char accumulated[] = { 0, 0, 0, 0 };
    
    for (long long i = 0; i < inputLength; i++)
    {
        unsigned char decoded = (unsigned char)lookup[inputBytes[i] & 0x7F];
        
        if (decoded != 99)
        {
            accumulated[accumulator] = decoded;
            
            if (accumulator == 3)
            {
                outputBytes[outputLength++] = (unsigned char)(accumulated[0] << 2) | (accumulated[1] >> 4);
                outputBytes[outputLength++] = (unsigned char)(accumulated[1] << 4) | (accumulated[2] >> 2);
                outputBytes[outputLength++] = (unsigned char)(accumulated[2] << 6) | accumulated[3];
            }
            
            accumulator = (accumulator + 1) % 4;
        }
    }
    
    //handle left-over data
    if (accumulator > 0) outputBytes[outputLength] = (unsigned char)(accumulated[0] << 2) | (accumulated[1] >> 4);
    
    if (accumulator > 1) outputBytes[++outputLength] = (unsigned char)(accumulated[1] << 4) | (accumulated[2] >> 2);
    
    if (accumulator > 2) outputLength++;
    
    //truncate data to match actual output length
    outputData.length = (NSUInteger)outputLength;
    return outputLength ? outputData : nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    //ensure wrapWidth is a multiple of 4
    wrapWidth = (wrapWidth / 4) * 4;
    
    const char lookup[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    long long inputLength = [self length];
    const unsigned char *inputBytes = [self bytes];
    
    long long maxOutputLength = (inputLength / 3 + 1) * 4;
    maxOutputLength += wrapWidth ? (maxOutputLength / wrapWidth) * 2 : 0;
    unsigned char *outputBytes = (unsigned char *)malloc((size_t)maxOutputLength);
    
    long long i;
    long long outputLength = 0;
    
    for (i = 0; i < inputLength - 2; i += 3)
    {
        outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = (unsigned char)lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = (unsigned char)lookup[((inputBytes[i + 1] & 0x0F) << 2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
        outputBytes[outputLength++] = (unsigned char)lookup[inputBytes[i + 2] & 0x3F];
        
        //add line break
        if (wrapWidth && (outputLength + 2) % (wrapWidth + 2) == 0)
        {
            outputBytes[outputLength++] = '\r';
            outputBytes[outputLength++] = '\n';
        }
    }
    
    //handle left-over data
    if (i == inputLength - 2)
    {
        // = terminator
        outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = (unsigned char)lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i + 1] & 0x0F) << 2];
        outputBytes[outputLength++] =   '=';
    }
    else if (i == inputLength - 1)
    {
        // == terminator
        outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0x03) << 4];
        outputBytes[outputLength++] = '=';
        outputBytes[outputLength++] = '=';
    }
    
    if (outputLength >= 4)
    {
        //truncate data to match actual output length
        outputBytes = realloc(outputBytes, (size_t)outputLength);
        return [[NSString alloc] initWithBytesNoCopy:outputBytes
                                                             length:(size_t)outputLength
                                                           encoding:NSASCIIStringEncoding
                                                       freeWhenDone:YES];
    }
    else if (outputBytes)
    {
        free(outputBytes);
    }
    
    return nil;
}

- (NSString *)base64EncodedString
{
    return [self base64EncodedStringWithWrapWidth:0];
}

@end

@implementation NSString (Help)

+ (NSString *)swithDate:(NSDate *)date toFormatDate:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSDate *timeIntervalDate = date;
    [formatter setDateFormat:format];
    return [formatter stringFromDate:timeIntervalDate];
}

- (NSString *)timeIntervalDefaultFormatToFormatDate:(NSString *)format
{
    return  [self timeIntervalOrigalFormat:@"yyyy-MM-dd HH:mm:ss" toFormatDate:format];
}

- (NSString *)timeIntervalOrigalFormat:(NSString *)origalFormat toFormatDate:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:origalFormat];
    NSDate *timeIntervalDate = [formatter dateFromString:self];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:timeIntervalDate];
}

- (NSString *)timeStampToFormatDate:(NSString *)format
{
    if (self.length == 0) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter  stringFromDate:date];
    return dateStr;
    
}

- (NSString *)replace:(NSString *)target withString:(NSString *)replacement {
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
};

/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)priceStringWithUnit:(BOOL)unit
{
//    if (self.length == 0)
//    {
//        return @"";
//    }
    CGFloat price = [self floatValue];
    if (unit)
    {
        return [NSString stringWithFormat:@"¥%.2f",price];
    }
    else
    {
        return [NSString stringWithFormat:@"%.2f",price];
    }
}


- (NSString *)md5_32bit {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

//手机号码判断
- (BOOL)isMobileNumber{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:self];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:self];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:self];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    return [data base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString
{
    NSData *data = [NSData dataWithBase64EncodedString:self];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSData *)base64DecodedData
{
    return [NSData dataWithBase64EncodedString:self];
}


//判断是否为整形：
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//邮箱正则表达式
- (BOOL)isValidateEmail
{
    
    if((0 != [self rangeOfString:@"@"].length) &&
       (0 != [self rangeOfString:@"."].length))
    {
        
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy] ;
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        //使用compare option 来设定比较规则，如
        //NSCaseInsensitiveSearch是不区分大小写
        //NSLiteralSearch 进行完全比较,区分大小写
        //NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
        NSRange range1 = [self rangeOfString:@"@"
                                     options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [self substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainString = [self substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;

}


@end
