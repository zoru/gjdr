//
//  NSDictionary+dictionaryExtension.h
//  Environmental
//
//  Created by CG on 15/9/5.
//  Copyright (c) 2015年 CG. All rights reserved.
//

#import "NSDictionary+dictionaryExtension.h"

@implementation NSDictionary (dictionaryExtension)
- (id)objectForNotNullKey:(id)aKey{
    if ([[self allKeys] containsObject:aKey]) {
        if (![[self objectForKey:aKey] isKindOfClass:[NSNull class]]) {
            return [self objectForKey:aKey];
        }
    }
    return @"";
}

-(BOOL)objectNotNullForKey:(id)key IsKindOfClass:(Class)classType
{
    if (![[self allKeys] containsObject:key]) {
        return NO;
    }
    if (![self objectForKey:key]) {
        return NO;
    }
    if (![[self objectForKey:key] isKindOfClass:classType]) {
        return NO;
    }
    return YES;
}

@end
