//
//  NSMutableDictionary+avoidCrash.m

//

#import "NSMutableDictionary+avoidCrash.h"


#import <objc/runtime.h>

@implementation NSDictionary (avoidCrash)

+ (void)load {
//    [__NSDictionaryM setObject:forKey:
//      Class arrayMClass = NSClassFromString(@"__NSDictionaryM");
    
//     initWithObjects:forKeys:count:
    Class arrayMClass = NSClassFromString(@"__NSDictionaryM");
    
    //获取系统的添加元素的方法
    Method addObject = class_getInstanceMethod(arrayMClass, @selector(setObject:forKey:));
    
    //获取我们自定义添加元素的方法
    Method avoidCrashAddObject = class_getInstanceMethod(arrayMClass, @selector(avoidCrashSetObject:forKey: ));
    
    //将两个方法进行交换
    //当你调用addObject,其实就是调用avoidCrashAddObject
    //当你调用avoidCrashAddObject，其实就是调用addObject
    method_exchangeImplementations(addObject, avoidCrashAddObject);
}

- (void)avoidCrashSetObject:(id)anObject forKey:(NSString *)key {
    
    @try {
        [self avoidCrashSetObject:anObject forKey:key];//其实就是调用addObject
    }
    @catch (NSException *exception) {
        
        //能来到这里,说明可变数组添加元素的代码有问题
        //你可以在这里进行相应的操作处理
        
        NSLog(@"异常名称:%@   异常原因:%@",exception.name, exception.reason);
    }
    @finally {
        //在这里的代码一定会执行，你也可以进行相应的操作
    }
}

@end
//字典和数组都可以用这个来避免
