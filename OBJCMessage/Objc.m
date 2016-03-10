//
//  Objc.m
//  OBJCMessage
//
//  Created by qianlongxu on 16/3/9.
//  Copyright © 2016年 qianlongxu. All rights reserved.
//

#import "Objc.h"
#import "objc/runtime.h"

@interface Objc ()

@property (nonatomic, strong) id target;

@end

@implementation Objc

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        self.target = target;
    }
    return self;
}

/*
void justTest(id self,SEL _cmd,NSString *str)
{
    NSLog(@"just printf:%@",str);
}

//在执行转发机制之前，提供了动态添加方法的机会；
+ (BOOL)resolveInstanceMethod:(SEL)selector
{
    if ([@"justTest:" isEqualToString:NSStringFromSelector(selector)]) {
        return class_addMethod(self, selector, (IMP)justTest, "v@:@");
    }else{
        return [super resolveInstanceMethod:selector];
    }
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    return YES;
}
*/

/*
//直接转发给响应的target；
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}
*/

- (void)aaaa
{}

//这里需要一个有效的签名；
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // 可以，这是一个有效的方法签名；不过不可使用self哦！
    return [super methodSignatureForSelector:@selector(aaaa)];
    // 尝试让 target 返回一个方法签名；target能签名，说明 target 能响应！否者直接崩掉吧！
    return [self.target methodSignatureForSelector:@selector(test:)];
    // 这个肯定不行！如果能签名也不至于来到这个方法了！
    return [super methodSignatureForSelector:aSelector];
}

//返回了有效方法签名后才会来到这个方法；注意 anInvocation 里包装的信息和方法签名并没有联系！
//anInvocation 里包装了 target：当前对象；方法：上面方法签名的参数一样；返回值类型；
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //偷梁换柱：把原本向 ocjc 对象发送的 justTest 消息转发给target处理，并发送新的消息 test
    [anInvocation setSelector:@selector(test:)];
    [anInvocation invokeWithTarget:self.target];
}

@end
