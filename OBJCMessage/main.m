//
//  main.m
//  OBJCMessage
//
//  Created by qianlongxu on 16/3/9.
//  Copyright © 2016年 qianlongxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Objc.h"
#import "Forward.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Forward *f = [[Forward alloc]init];
        Objc *obj = [[Objc alloc]initWithTarget:f];
        
        id objc = obj;
        [objc performSelector:NSSelectorFromString(@"justTest:") withObject:@"fsddsf"];
    }
    return 0;
}
