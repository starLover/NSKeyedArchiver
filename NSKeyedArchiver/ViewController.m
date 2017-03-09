//
//  ViewController.m
//  NSKeyedArchiver
//
//  Created by starlover on 2017/3/8.
//  Copyright © 2017年 starlover. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //practice
    
    //单个对象归档与反归档
    [self saveSingleObject:@"singleObject" to:@"single"];
    NSString *singleObject = [self loadSingleObjectFrom:@"single"];
    NSLog(@"%@", singleObject);
    
    //多个对象的归档与反归档
    [self saveMultipleObject:@"object" object1:@{@"key1": @"object1"} to:@"multiple"];
    [self loadObjectFrom:@"multiple" block:^(id object, id object1) {
        NSLog(@"%@, %@", object, object1);
    }];
    
    //自定义对象的归档与反归档
    People *people = [[People alloc] init];
    people.name = @"star";
    people.age = 18;
    people.address = @"London";
    [self saveSingleObject:people to:@"people"];
    
    People *samePeople = [self loadSingleObjectFrom:@"people"];
    NSLog(@"%@", [samePeople description]);
    
}

#pragma mark     单个对象进行归档及反归档
//归档
- (void)saveSingleObject:(id)object to:(NSString *)filename{
    NSString *path = [self documentDirectory:filename];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:path];
    NSLog(@"单个文件%@", success ? @"存储成功" : @"存储失败");
}
//反归档
- (id)loadSingleObjectFrom:(NSString *)filename{
    NSString *path = [self documentDirectory:filename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) { return nil; }
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return object;
}


#pragma mark     多个对象进行归档和反归档
//多个对象归档
- (void)saveMultipleObject:(id)object object1:(id)object1 to:(NSString *)filename{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archiver encodeObject:object forKey:@"key"];
    [archiver encodeObject:object1 forKey:@"key1"];
    [archiver finishEncoding];
    
    NSString *path = [self documentDirectory:filename];
    //说明：这里的atomically参数让该方法将数据写入辅助文件，而不是写入指定位置。成功写入该文件之后，辅助文件将被复制到第一个参数指定的位置。这是更安全的写入文件的方法，因为如果应用在保存期间崩溃，则现有文件（如果有）不会被破坏。尽管增加一点开销，但是多数情况下还是值得的。
    BOOL success = [data writeToFile:path atomically:YES];
    NSLog(@"多个文件%@", success ? @"存储成功" : @"存储失败");
}
//多个对象反归档
- (void)loadObjectFrom:(NSString *)filename block:(void(^)(id object, id object1))block{
    NSString *path = [self documentDirectory:filename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) { return; }
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //解码
    id object = [unarchiver decodeObjectForKey:@"key"];
    id object1 = [unarchiver decodeObjectForKey:@"key1"];
    [unarchiver finishDecoding];
    
    if (!block) { return; }
    block(object, object1);
    
}

/*
 !!!注意： 只有遵循了NSCoding协议的类才能够归档和反归档
          自定义的类若要进行归档和反归档可以参考 People类
*/

//获取documents文件夹下对应的目录
- (NSString *)documentDirectory:(NSString *)filename{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documents stringByAppendingPathComponent:filename];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
