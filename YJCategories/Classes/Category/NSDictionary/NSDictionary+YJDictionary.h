//
//  NSDictionary+YJDictionary.h
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YJDictionary)
/// num => string
- (id)yjNumValueToStringForKey:(NSString *)key;
/// null => nil
- (id)yjNunullValueForKey:(NSString *)key;
/// null => nil
- (id)yjNunullObjectForKey:(NSString *)key;
/// null => ""
- (NSString *)yjNunullStringForKey:(NSString *)key;

@end
