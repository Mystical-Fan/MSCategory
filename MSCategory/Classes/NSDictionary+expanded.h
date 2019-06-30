//
//  NSDictionaryCategory.h
//  cloud
//
//  Created by hetao on 11-4-19.
//  Copyright 2011年 oulin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (expanded)

/*
 *把服务器返回的 NULL 替换为@“”
 *json表示获取到的带有NULL对象的json数据
 *NSDictionary *newDict = [NSDictionary changeType:json];
 */
+ (id)changeType:(id)myObj;

- (id)objectForJSONKey:(id)aKey;
- (id)valueForJSONKey:(NSString *)key;
- (id)valueForJSONKeys:(NSString *)key,...NS_REQUIRES_NIL_TERMINATION;
- (id)valueForJSONStrKeys:(NSString *)key,...NS_REQUIRES_NIL_TERMINATION;
- (void)setObjects:(id)objects forKey:(id)aKey;

- (NSString*)valueForJSONStrKey:(NSString *)key;
- (void)removeObject:(id)object forKey:(id)aKey;

@end
