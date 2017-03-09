//
//  People.m
//  NSKeyedArchiver
//
//  Created by starlover on 2017/3/8.
//  Copyright © 2017年 starlover. All rights reserved.
//

#import "People.h"

@implementation People

//序列化
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.address forKey:@"address"];
}

//反序列化
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (!self) { return nil; }
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    return self;
}

- (NSString *)description{
    NSString *description = [NSString stringWithFormat:@"name:%@, age:%lu, address:%@", self.name, self.age, self.address];
    return description;
}



@end
