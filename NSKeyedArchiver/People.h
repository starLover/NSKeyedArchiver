//
//  People.h
//  NSKeyedArchiver
//
//  Created by starlover on 2017/3/8.
//  Copyright © 2017年 starlover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject<NSCoding>     // 给自定义类归档，首先要遵守NSCoding协议。

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSUInteger age;

@property (nonatomic, copy) NSString *address;

- (NSString *)description;

@end
