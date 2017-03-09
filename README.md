# NSKeyedArchiver and  NSKeyedUnarchiver

- 归档

> 普通自定义对象和字节流之间的转换

- 反归档

> 字节流和普通自定义对象之间的转换

- 序列化

> 某些特定类型如（NSDictionary, NSArray, NSString, NSDate, NSNumber，NSData）的数据和字节流之间(通常将其保存为plist文件)的转换

- 反序列化

> 和序列化相反的过程
遵循NSCoding协议的对象都可以进行序列化和反序列化
