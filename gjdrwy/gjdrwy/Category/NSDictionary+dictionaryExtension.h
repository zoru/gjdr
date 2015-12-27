//
//  NSDictionary+dictionaryExtension.h
//  Environmental
//
//  Created by CG on 15/9/5.
//  Copyright (c) 2015年 CG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (dictionaryExtension)

-(id)objectForNotNullKey:(id)aKey;

-(BOOL)objectNotNullForKey:(id)key IsKindOfClass:(Class)classType;

@end
