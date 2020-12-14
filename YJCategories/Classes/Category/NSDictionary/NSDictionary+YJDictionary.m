//
//  NSDictionary+YJDictionary.m
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import "NSDictionary+YJDictionary.h"

@implementation NSDictionary (YJDictionary)

- (id)yjNumValueToStringForKey:(NSString *)key {
    id object = [self valueForKey:key];
    if (object == nil) return object;
    if ([object isEqual:[NSNull null]]) return nil;
    
    return [NSString stringWithFormat:@"%@", object];
}

- (id)yjNunullValueForKey:(NSString *)key {
    id object = [self valueForKey:key];
    if ([object isEqual:[NSNull null]]) return nil;
    
    return object;
}

- (id)yjNunullObjectForKey:(NSString *)key {
    id object = [self objectForKey:key];
    if ([object isEqual:[NSNull null]]) return nil;
    
    return object;
}

- (NSString *)yjNunullStringForKey:(NSString *)key {
    id object = [self yjNunullValueForKey:key];
    if (object == nil) return @"";
    
    return [NSString stringWithFormat:@"%@", object];
}

@end
