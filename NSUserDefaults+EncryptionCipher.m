//
//  NSUserDefaults+EncryptionCipher.m
//   
//
//  Created by iskf on 2017/3/3.
//  https://github.com/iskf
//

#import "NSUserDefaults+EncryptionCipher.h"

#import <objc/runtime.h>

#define kStoredObjectKey              @"kf_Encryption"

static NSString *_secret = @"kf123456789";

@implementation NSUserDefaults (EncryptionCipher)
+(void)load
{
    /** setValue:forKey: */
    Method sys_setValueForKeyM = class_getInstanceMethod([self class], @selector(setValue:forKey:));
    Method kf_setValueForKeyM = class_getInstanceMethod([self class], @selector(kf_setValue:forKey:));
    method_exchangeImplementations(sys_setValueForKeyM, kf_setValueForKeyM);
    /** valueForKey: */
    Method sys_valueForKeyM = class_getInstanceMethod([self class], @selector(valueForKey:));
    Method kf_valueForKeyM = class_getInstanceMethod([self class], @selector(kf_valueForKey:));
    method_exchangeImplementations(sys_valueForKeyM, kf_valueForKeyM);
    
    /** setObject:forKey: */
    Method sys_setObjectForKeyM = class_getInstanceMethod([self class], @selector(setObject:forKey:));
    Method kf_setObjectForKeyM = class_getInstanceMethod([self class], @selector(kf_setObject:forKey:));
    method_exchangeImplementations(sys_setObjectForKeyM, kf_setObjectForKeyM);
    /** objectForKey: */
    Method sys_objectForKeyM = class_getInstanceMethod([self class], @selector(objectForKey:));
    Method kf_objectForKeyM = class_getInstanceMethod([self class], @selector(kf_objectForKey:));
    method_exchangeImplementations(sys_objectForKeyM, kf_objectForKeyM);
    
    /** setBool:forKey: */
    Method sys_setBoolForKeyM = class_getInstanceMethod([self class], @selector(setBool:forKey:));
    Method kf_setBoolForKeyM = class_getInstanceMethod([self class], @selector(kf_setBool:forKey:));
    method_exchangeImplementations(sys_setBoolForKeyM, kf_setBoolForKeyM);
    /** boolForKey: */
    Method sys_boolForKeyM = class_getInstanceMethod([self class], @selector(boolForKey:));
    Method kf_boolForKeyM = class_getInstanceMethod([self class], @selector(kf_boolForKey:));
    method_exchangeImplementations(sys_boolForKeyM, kf_boolForKeyM);
    
    /** setBool:forKey: */
    Method sys_setIntegerForKeyM = class_getInstanceMethod([self class], @selector(setInteger:forKey:));
    Method kf_setIntegerForKeyM = class_getInstanceMethod([self class], @selector(kf_setInteger:forKey:));
    method_exchangeImplementations(sys_setIntegerForKeyM, kf_setIntegerForKeyM);
    /** boolForKey: */
    Method sys_integerForKeyM = class_getInstanceMethod([self class], @selector(integerForKey:));
    Method kf_integerForKeyM = class_getInstanceMethod([self class], @selector(kf_integerForKey:));
    method_exchangeImplementations(sys_integerForKeyM, kf_integerForKeyM);
    
    /** setFloat:forKey: */
    Method sys_setFloatForKeyM = class_getInstanceMethod([self class], @selector(setFloat:forKey:));
    Method kf_setFloatForKeyM = class_getInstanceMethod([self class], @selector(kf_setFloat:forKey:));
    method_exchangeImplementations(sys_setFloatForKeyM, kf_setFloatForKeyM);
    /** floatForKey: */
    Method sys_floatForKeyM = class_getInstanceMethod([self class], @selector(floatForKey:));
    Method kf_floatForKeyM = class_getInstanceMethod([self class], @selector(kf_floatForKey:));
    method_exchangeImplementations(sys_floatForKeyM, kf_floatForKeyM);
    
    /** setDouble:forKey: */
    Method sys_setDoubleForKeyM = class_getInstanceMethod([self class], @selector(setDouble:forKey:));
    Method kf_setDoubleForKeyM = class_getInstanceMethod([self class], @selector(kf_setDouble:forKey:));
    method_exchangeImplementations(sys_setDoubleForKeyM, kf_setDoubleForKeyM);
    /** doubleForKey: */
    Method sys_doubleForKeyM = class_getInstanceMethod([self class], @selector(doubleForKey:));
    Method kf_doubleForKeyM = class_getInstanceMethod([self class], @selector(kf_doubleForKey:));
    method_exchangeImplementations(sys_doubleForKeyM, kf_doubleForKeyM);
    
    /** setURL:forKey: */
    Method sys_setURLForKeyM = class_getInstanceMethod([self class], @selector(setURL:forKey:));
    Method kf_setURLForKeyM = class_getInstanceMethod([self class], @selector(kf_setURL:forKey:));
    method_exchangeImplementations(sys_setURLForKeyM, kf_setURLForKeyM);
    /** URLForKey: */
    Method sys_URLForKeyM = class_getInstanceMethod([self class], @selector(URLForKey:));
    Method kf_URLForKeyM = class_getInstanceMethod([self class], @selector(kf_URLForKey:));
    method_exchangeImplementations(sys_URLForKeyM, kf_URLForKeyM);
    
    /** dataForKey: */
    Method sys_dataForKeyM = class_getInstanceMethod([self class], @selector(dataForKey:));
    Method kf_dataForKeyM = class_getInstanceMethod([self class], @selector(kf_dataForKey:));
    method_exchangeImplementations(sys_dataForKeyM, kf_dataForKeyM);
    
    /** arrayForKey: */
    Method sys_arrayForKeyM = class_getInstanceMethod([self class], @selector(arrayForKey:));
    Method kf_arrayForKeyM = class_getInstanceMethod([self class], @selector(kf_arrayForKey:));
    method_exchangeImplementations(sys_arrayForKeyM, kf_arrayForKeyM);
    
    /** dictionaryForKey: */
    Method sys_dictionaryForKeyM = class_getInstanceMethod([self class], @selector(dictionaryForKey:));
    Method kf_dictionaryForKeyM = class_getInstanceMethod([self class], @selector(kf_dictionaryForKey:));
    method_exchangeImplementations(sys_dictionaryForKeyM, kf_dictionaryForKeyM);
}





-(id)kf_valueForKey:(NSString *)key
{
    id obj = [self kf_secretObjectForKey:key];
    [self kf_objectForKey:key];
    return obj;
}

-(id)kf_objectForKey:(NSString *)defaultName
{
    [self kf_objectForKey:defaultName];
    id obj = [self kf_secretObjectForKey:defaultName];
    return obj;
}
-(BOOL)kf_boolForKey:(NSString *)defaultName
{
    id object = [self kf_secretObjectForKey:defaultName];
    [self kf_boolForKey:defaultName];
    if([object isKindOfClass:[NSNumber class]]) {
        return [object boolValue];
    } else {
        return NO;
    }
}

-(NSInteger)kf_integerForKey:(NSString *)defaultName
{
    id object = [self kf_secretObjectForKey:defaultName];
    [self kf_integerForKey:defaultName];
    if([object isKindOfClass:[NSNumber class]]) {
        return [object integerValue];
    } else {
        return 0;
    }
}

-(float)kf_floatForKey:(NSString *)defaultName
{
    id object = [self kf_secretObjectForKey:defaultName];
    [self kf_floatForKey:defaultName];
    if([object isKindOfClass:[NSNumber class]]) {
        return [object floatValue];
    } else {
        return 0.f;
    }
}

-(double)kf_doubleForKey:(NSString *)defaultName
{
    id object = [self kf_secretObjectForKey:defaultName];
    [self kf_doubleForKey:defaultName];
    if([object isKindOfClass:[NSNumber class]]) {
        return [object doubleValue];
    } else {
        return 0;
    }
}

-(NSURL *)kf_URLForKey:(NSString *)defaultName
{
    id object = [self kf_secretObjectForKey:defaultName];
    [self kf_URLForKey:defaultName];
    if([object isKindOfClass:[NSURL class]]) {
        return object;
    } else {
        return nil;
    }
}

-(NSData *)kf_dataForKey:(NSString *)defaultName
{
    id object = [self kf_secretObjectForKey:defaultName];
    [self kf_dataForKey:defaultName];
    if([object isKindOfClass:[NSData class]]) {
        return object;
    } else {
        return nil;
    }
}

-(NSArray *)kf_arrayForKey:(NSString *)defaultName
{
    id objects = [self kf_secretObjectForKey:defaultName];
    [self kf_arrayForKey:defaultName];
    if([objects isKindOfClass:[NSArray class]]) {
        for(id object in objects) {
            if(![object isKindOfClass:[NSString class]]) {
                return nil;
            }
        }
        return objects;
    } else {
        return nil;
    }
}

-(NSDictionary<NSString *,id> *)kf_dictionaryForKey:(NSString *)defaultName
{
    id object = [self kf_secretObjectForKey:defaultName];
    [self kf_dictionaryForKey:defaultName];
    if([object isKindOfClass:[NSDictionary class]]) {
        return object;
    } else {
        return nil;
    }
    
}

- (id)kf_secretObjectForKey:(NSString *)defaultName
{
    NSAssert(_secret, @"Secret may not be nil when storing an object securely");
    
    NSData *data = [self kf_objectForKey:defaultName];
    if(data == nil) {
        return nil;
    }
    
    @try {
        
        CocoaSecurityResult *keyData = [CocoaSecurity sha384:_secret];
        NSData *aesKey = [keyData.data subdataWithRange:NSMakeRange(0, 32)];
        NSData *aesIv = [keyData.data subdataWithRange:NSMakeRange(32, 16)];
        
        CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithData:data key:aesKey iv:aesIv];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:result.data];
        id object = [unarchiver decodeObjectForKey:kStoredObjectKey];
        [unarchiver finishDecoding];
        return object;
    }
    @catch (NSException *exception) {
        NSLog(@"Cannot receive object from encrypted data storage: %@", exception.reason);
        return nil;
    }
    @finally {}
}




-(void)kf_setValue:(id)value forKey:(NSString *)key
{
    //TO DO encryption
    [self kf_setSecretObject:value forKey:key];
    
   // [self kf_setValue:value forKey:key];
}

-(void)kf_setObject:(id)value forKey:(NSString *)defaultName
{
    [self kf_setSecretObject:value forKey:defaultName];
    
    //[self kf_setObject:value forKey:defaultName];
    
}

-(void)kf_setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [self kf_setSecretObject:[NSNumber numberWithBool:value] forKey:defaultName];
   // [self kf_setBool:value forKey:defaultName];
}

-(void)kf_setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    [self kf_setSecretObject:[NSNumber numberWithInteger:value] forKey:defaultName];
   // [self kf_setInteger:value forKey:defaultName];
}

-(void)kf_setFloat:(float)value forKey:(NSString *)defaultName
{
    [self kf_setSecretObject:[NSNumber numberWithFloat:value] forKey:defaultName];
  //  [self kf_setFloat:value forKey:defaultName];
}

-(void)kf_setDouble:(double)value forKey:(NSString *)defaultName
{
    [self kf_setSecretObject:[NSNumber numberWithDouble:value] forKey:defaultName];
   // [self kf_setDouble:value forKey:defaultName];
}

-(void)kf_setURL:(NSURL *)url forKey:(NSString *)defaultName
{
    [self kf_setSecretObject:url forKey:defaultName];
  //  [self kf_setURL:url forKey:defaultName];
}


- (void)kf_setSecretObject:(id)value forKey:(NSString *)defaultName
{
    NSAssert(_secret, @"Secret may not be nil when storing an object securely");
    @try {
        
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:value forKey:kStoredObjectKey];
        [archiver finishEncoding];
        
        CocoaSecurityResult *keyData = [CocoaSecurity sha384:_secret];
        NSData *aesKey = [keyData.data subdataWithRange:NSMakeRange(0, 32)];
        NSData *aesIv = [keyData.data subdataWithRange:NSMakeRange(32, 16)];
        
        CocoaSecurityResult *result = [CocoaSecurity aesEncryptWithData:data key:aesKey iv:aesIv];
        
        [self kf_setObject:result.data forKey:defaultName];
    }
    @catch (NSException *exception) {
        NSLog(@"Cannot store object securely: %@", exception.reason);
    }
    @finally {}
}

// https://github.com/iskf
@end



#pragma GCC diagnostic ignored "-Wselector"


#import <Availability.h>
#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif




@implementation NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    
    NSData *decoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else
    
#endif
        
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    
    return [decoded length]? decoded: nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        encoded = [self base64Encoding];
    }
    else
    
#endif
    
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)base64EncodedString
{
    return [self base64EncodedStringWithWrapWidth:0];
}

@end


@implementation NSString (Base64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
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
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData
{
    return [NSData dataWithBase64EncodedString:self];
}

@end


#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

#pragma mark - CocoaSecurity
@implementation CocoaSecurity


#pragma mark - AES Encrypt
// default AES Encrypt, key -> SHA384(key).sub(0, 32), iv -> SHA384(key).sub(32, 16)
+ (CocoaSecurityResult *)aesEncrypt:(NSString *)data key:(NSString *)key
{
    CocoaSecurityResult * sha = [self sha384:key];
    NSData *aesKey = [sha.data subdataWithRange:NSMakeRange(0, 32)];
    NSData *aesIv = [sha.data subdataWithRange:NSMakeRange(32, 16)];
    
    return [self aesEncrypt:data key:aesKey iv:aesIv];
}
#pragma mark AES Encrypt 128, 192, 256
+ (CocoaSecurityResult *)aesEncrypt:(NSString *)data hexKey:(NSString *)key hexIv:(NSString *)iv
{
    CocoaSecurityDecoder *decoder = [CocoaSecurityDecoder new];
    NSData *aesKey = [decoder hex:key];
    NSData *aesIv = [decoder hex:iv];
    
    return [self aesEncrypt:data key:aesKey iv:aesIv];
}
+ (CocoaSecurityResult *)aesEncrypt:(NSString *)data key:(NSData *)key iv:(NSData *)iv
{
    return [self aesEncryptWithData:[data dataUsingEncoding:NSUTF8StringEncoding] key:key iv:iv];
}
+ (CocoaSecurityResult *)aesEncryptWithData:(NSData *)data key:(NSData *)key iv:(NSData *)iv
{
    // check length of key and iv
    if ([iv length] != 16) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of iv is wrong. Length of iv should be 16(128bits)"
                                     userInfo:nil];
    }
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)"
                                     userInfo:nil];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [key bytes],     // Key
                                          [key length],    // kCCKeySizeAES
                                          [iv bytes],       // IV
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        
        return result;
    }
    else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Encrypt Error!"
                                     userInfo:nil];
        return nil;
    }
}
#pragma mark - AES Decrypt
// default AES Decrypt, key -> SHA384(key).sub(0, 32), iv -> SHA384(key).sub(32, 16)
+ (CocoaSecurityResult *)aesDecryptWithBase64:(NSString *)data key:(NSString *)key
{
    CocoaSecurityResult * sha = [self sha384:key];
    NSData *aesKey = [sha.data subdataWithRange:NSMakeRange(0, 32)];
    NSData *aesIv = [sha.data subdataWithRange:NSMakeRange(32, 16)];
    
    return [self aesDecryptWithBase64:data key:aesKey iv:aesIv];
}
#pragma mark AES Decrypt 128, 192, 256
+ (CocoaSecurityResult *)aesDecryptWithBase64:(NSString *)data hexKey:(NSString *)key hexIv:(NSString *)iv
{
    CocoaSecurityDecoder *decoder = [CocoaSecurityDecoder new];
    NSData *aesKey = [decoder hex:key];
    NSData *aesIv = [decoder hex:iv];
    
    return [self aesDecryptWithBase64:data key:aesKey iv:aesIv];
}
+ (CocoaSecurityResult *)aesDecryptWithBase64:(NSString *)data key:(NSData *)key iv:(NSData *)iv
{
    CocoaSecurityDecoder *decoder = [CocoaSecurityDecoder new];
    return [self aesDecryptWithData:[decoder base64:data] key:key iv:iv];
}
+ (CocoaSecurityResult *)aesDecryptWithData:(NSData *)data key:(NSData *)key iv:(NSData *)iv
{
    // check length of key and iv
    if ([iv length] != 16) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of iv is wrong. Length of iv should be 16(128bits)"
                                     userInfo:nil];
    }
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)"
                                     userInfo:nil];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [key bytes],     // Key
                                          [key length],    // kCCKeySizeAES
                                          [iv bytes],       // IV
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        
        return result;
    }
    else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Decrypt Error!"
                                     userInfo:nil];
        return nil;
    }
}


#pragma mark - MD5
+ (CocoaSecurityResult *)md5:(NSString *)hashString
{
    return [self md5WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding]];
}
+ (CocoaSecurityResult *)md5WithData:(NSData *)hashData
{
    unsigned char *digest;
    digest = malloc(CC_MD5_DIGEST_LENGTH);
    
    CC_MD5([hashData bytes], (CC_LONG)[hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    free(digest);
    
    return result;
}
#pragma mark - HMAC-MD5
+ (CocoaSecurityResult *)hmacMd5:(NSString *)hashString hmacKey:(NSString *)key
{
    return [self hmacMd5WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding] hmacKey:key];
}
+ (CocoaSecurityResult *)hmacMd5WithData:(NSData *)hashData hmacKey:(NSString *)key
{
    unsigned char *digest;
    digest = malloc(CC_MD5_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    CCHmac(kCCHmacAlgMD5, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    
    return result;
}


#pragma mark - SHA1
+ (CocoaSecurityResult *)sha1:(NSString *)hashString
{
    return [self sha1WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding]];
}
+ (CocoaSecurityResult *)sha1WithData:(NSData *)hashData
{
    unsigned char *digest;
    digest = malloc(CC_SHA1_DIGEST_LENGTH);
    
    CC_SHA1([hashData bytes], (CC_LONG)[hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    free(digest);
    
    return result;
}
#pragma mark SHA224
+ (CocoaSecurityResult *)sha224:(NSString *)hashString
{
    return [self sha224WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding]];
}
+ (CocoaSecurityResult *)sha224WithData:(NSData *)hashData
{
    unsigned char *digest;
    digest = malloc(CC_SHA224_DIGEST_LENGTH);
    
    CC_SHA224([hashData bytes], (CC_LONG)[hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA224_DIGEST_LENGTH];
    free(digest);
    
    return result;
}
#pragma mark SHA256
+ (CocoaSecurityResult *)sha256:(NSString *)hashString
{
    return [self sha256WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding]];
}
+ (CocoaSecurityResult *)sha256WithData:(NSData *)hashData
{
    unsigned char *digest;
    digest = malloc(CC_SHA256_DIGEST_LENGTH);
    
    CC_SHA256([hashData bytes], (CC_LONG)[hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    free(digest);
    
    return result;
}
#pragma mark SHA384
+ (CocoaSecurityResult *)sha384:(NSString *)hashString
{
    return [self sha384WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding]];
}
+ (CocoaSecurityResult *)sha384WithData:(NSData *)hashData
{
    unsigned char *digest;
    digest = malloc(CC_SHA384_DIGEST_LENGTH);
    
    CC_SHA384([hashData bytes], (CC_LONG)[hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA384_DIGEST_LENGTH];
    free(digest);
    
    return result;
}
#pragma mark SHA512
+ (CocoaSecurityResult *)sha512:(NSString *)hashString
{
    return [self sha512WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding]];
}
+ (CocoaSecurityResult *)sha512WithData:(NSData *)hashData
{
    unsigned char *digest;
    digest = malloc(CC_SHA512_DIGEST_LENGTH);
    
    CC_SHA512([hashData bytes], (CC_LONG)[hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    free(digest);
    
    return result;
}


#pragma mark - HMAC-SHA1
+ (CocoaSecurityResult *)hmacSha1:(NSString *)hashString hmacKey:(NSString *)key
{
    return [self hmacSha1WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding] hmacKey:key];
}
+ (CocoaSecurityResult *)hmacSha1WithData:(NSData *)hashData hmacKey:(NSString *)key
{
    unsigned char *digest;
    digest = malloc(CC_SHA1_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    
    return result;
}
#pragma mark HMAC-SHA224
+ (CocoaSecurityResult *)hmacSha224:(NSString *)hashString hmacKey:(NSString *)key
{
   return [self hmacSha224WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding] hmacKey:key];
}
+ (CocoaSecurityResult *)hmacSha224WithData:(NSData *)hashData hmacKey:(NSString *)key
{
    unsigned char *digest;
    digest = malloc(CC_SHA224_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    CCHmac(kCCHmacAlgSHA224, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA224_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    
    return result;
}
#pragma mark HMAC-SHA256
+ (CocoaSecurityResult *)hmacSha256:(NSString *)hashString hmacKey:(NSString *)key
{
    return [self hmacSha256WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding] hmacKey:key];
}
+ (CocoaSecurityResult *)hmacSha256WithData:(NSData *)hashData hmacKey:(NSString *)key
{
    unsigned char *digest;
    digest = malloc(CC_SHA256_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    
    return result;
}
#pragma mark HMAC-SHA384
+ (CocoaSecurityResult *)hmacSha384:(NSString *)hashString hmacKey:(NSString *)key
{
    return [self hmacSha384WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding] hmacKey:key];
}
+ (CocoaSecurityResult *)hmacSha384WithData:(NSData *)hashData hmacKey:(NSString *)key
{
    unsigned char *digest;
    digest = malloc(CC_SHA384_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    CCHmac(kCCHmacAlgSHA384, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA384_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    
    return result;
}
#pragma mark HMAC-SHA512
+ (CocoaSecurityResult *)hmacSha512:(NSString *)hashString hmacKey:(NSString *)key
{
    return [self hmacSha512WithData:[hashString dataUsingEncoding:NSUTF8StringEncoding] hmacKey:key];
}
+ (CocoaSecurityResult *)hmacSha512WithData:(NSData *)hashData hmacKey:(NSString *)key
{
    unsigned char *digest;
    digest = malloc(CC_SHA512_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    
    return result;
}

@end



#pragma mark - CocoaSecurityResult
@implementation CocoaSecurityResult

@synthesize data = _data;

#pragma mark - Init
- (id)initWithBytes:(unsigned char[])initData length:(NSUInteger)length
{
    self = [super init];
    if (self) {
        _data = [NSData dataWithBytes:initData length:length];
    }
    return self;
}

#pragma mark UTF8 String
// convert CocoaSecurityResult to UTF8 string
- (NSString *)utf8String
{
    NSString *result = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    return result;
}

#pragma mark HEX
// convert CocoaSecurityResult to HEX string
- (NSString *)hex
{
    CocoaSecurityEncoder *encoder = [CocoaSecurityEncoder new];
    return [encoder hex:_data useLower:false];
}
- (NSString *)hexLower
{
    CocoaSecurityEncoder *encoder = [CocoaSecurityEncoder new];
    return [encoder hex:_data useLower:true];
}

#pragma mark Base64
// convert CocoaSecurityResult to Base64 string
- (NSString *)base64
{
    CocoaSecurityEncoder *encoder = [CocoaSecurityEncoder new];
    return [encoder base64:_data];
}

@end


#pragma mark - CocoaSecurityEncoder
@implementation CocoaSecurityEncoder

// convert NSData to Base64
- (NSString *)base64:(NSData *)data
{
    return [data base64EncodedString];
}

// convert NSData to hex string
- (NSString *)hex:(NSData *)data useLower:(BOOL)isOutputLower
{
    if (data.length == 0) { return nil; }
    
    static const char HexEncodeCharsLower[] = "0123456789abcdef";
    static const char HexEncodeChars[] = "0123456789ABCDEF";
    char *resultData;
    // malloc result data
    resultData = malloc([data length] * 2 +1);
    // convert imgData(NSData) to char[]
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    NSUInteger length = [data length];
    
    if (isOutputLower) {
        for (NSUInteger index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    }
    else {
        for (NSUInteger index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    
    // convert result(char[]) to NSString
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    
    return result;
}

@end

#pragma mark - CocoaSecurityDecoder
@implementation CocoaSecurityDecoder
- (NSData *)base64:(NSString *)string
{
    return [NSData dataWithBase64EncodedString:string];
}
- (NSData *)hex:(NSString *)data
{
    if (data.length == 0) { return nil; }
    
    static const unsigned char HexDecodeChars[] =
    {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, //49
        2, 3, 4, 5, 6, 7, 8, 9, 0, 0, //59
        0, 0, 0, 0, 0, 10, 11, 12, 13, 14,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //79
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 10, 11, 12,   //99
        13, 14, 15
    };
    
    // convert data(NSString) to CString
    const char *source = [data cStringUsingEncoding:NSUTF8StringEncoding];
    // malloc buffer
    unsigned char *buffer;
    NSUInteger length = strlen(source) / 2;
    buffer = malloc(length);
    for (NSUInteger index = 0; index < length; index++) {
        buffer[index] = (HexDecodeChars[source[index * 2]] << 4) + (HexDecodeChars[source[index * 2 + 1]]);
    }
    // init result NSData
    NSData *result = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    source = nil;
    
    return  result;
}

@end
