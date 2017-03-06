//
//  NSUserDefaults+EncryptionCipher.m
//  OAuth_Demo
//
//  Created by InnoeriOS1 on 2017/3/3.
//  qq:24272779
//

#import "NSUserDefaults+EncryptionCipher.h"

#import <objc/runtime.h>
#import "CocoaSecurity.h"

#define kStoredObjectKey              @"kf_Encryption"

static NSString *_secret = @"innoways";

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

//  qq:24272779
@end
