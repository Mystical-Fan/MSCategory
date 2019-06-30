//
//  NSDictionaryCategory.m
//  cloud
//
//  Created by hetao on 11-4-19.
//  Copyright 2011年 oulin. All rights reserved.
//

#import "NSDictionary+expanded.h"


@implementation NSDictionary (expanded)
//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        obj = [self changeType:obj];
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}
//将NSArray中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        obj = [self changeType:obj];
        [resArr addObject:obj];
    }
    return resArr;
}
//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}
//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}
//主要方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }    
    else if([myObj isKindOfClass:[NSNull class]])    
    {    
        return [self nullToString];    
    }    
    else    
    {    
        return myObj;    
    }
}

- (id)objectForJSONKey:(id)aKey
{
    id value = [self objectForKey:aKey];
    if (!value||value==[NSNull null]) {
        return @"";
    }else{
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@",value];
        }
        else if([value isKindOfClass:[NSString class]]){
            if ([value isEqualToString:@""] || [value isEqualToString:@"null"]) {
                return  @"";
            }
        }
        return value;
    }
}
- (NSString*)valueForJSONStrKey:(NSString *)key
{
    NSString *str = [self valueForJSONKey:key];
    return str?str:@"";
}
- (id)valueForJSONKey:(NSString *)key
{
    id value = [self valueForKey:key];
    if (!value||value==[NSNull null]) {
        return nil;
    }else{
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@",value];
        }else if([value isKindOfClass:[NSString class]]){
            if ([value isEqualToString:@""] || [value isEqualToString:@"null"] || [value isEqualToString:@"<null>"]) {
                return  nil;
            }
        }
        return value;
    }
}

- (id)valueForJSONStrKeys:(NSString *)key,...NS_REQUIRES_NIL_TERMINATION
{
    id object=[self valueForJSONKey:key];
    NSString *akey;
    va_list ap;
    va_start(ap, key);
    while (object&&(akey=va_arg(ap,id))) {
        object=[object valueForJSONKey:akey];
    }
    va_end(ap);
    return object?object:@"";
}

- (id)valueForJSONKeys:(NSString *)key,...NS_REQUIRES_NIL_TERMINATION
{
    id object=[self valueForJSONKey:key];
    NSString *akey;
    va_list ap;
    va_start(ap, key);
    while (object&&(akey=va_arg(ap,id))) {
        object=[object valueForJSONKey:akey];
    }
    va_end(ap);
    return object;
}
//always return an array
- (void)setObjects:(id)objects forKey:(id)aKey
{
    if (!aKey || !objects || ![self isKindOfClass:[NSMutableDictionary class]]) {
        return;
    }
    if ([self objectForKey:aKey]) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[self objectForKey:aKey]];
        [array addObject:objects];
        [(NSMutableDictionary*)self setObject:array forKey:aKey];
    }
    else
    {
        [(NSMutableDictionary*)self setObject:[NSMutableArray arrayWithObject:objects] forKey:aKey];
    }
}
- (void)removeObject:(id)object forKey:(id)aKey
{
    if (!aKey || ![self isKindOfClass:[NSMutableDictionary class]]) {
        return;
    }
    if ([self objectForKey:aKey]) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[self objectForKey:aKey]];
        [array removeObject:object];
        if (array.count) {
            [(NSMutableDictionary*)self setObject:array forKey:aKey];
        }else{
            [(NSMutableDictionary*)self removeObjectForKey:aKey];
        }
    }
}
@end
