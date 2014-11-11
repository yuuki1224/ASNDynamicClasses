//
//  ASNDynamicClasses.m
//  ASNDynamicClasses
//
//  Created by AsanoYuki on 2014/11/11.
//  Copyright (c) 2014年 AsanoYuki. All rights reserved.
//

#import "ASNDynamicClasses.h"
#import <objc/runtime.h>

@implementation ASNDynamicClasses

-(instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        self.path = path;
        self.generatedClasses = [self p_generateClassesWithPath:self.path];
    }
    
    return self;
}

-(id)generateClass:(Class)cls
{
    return self;
}

#pragma mark - private

// generateClassesWithPathとかいうinitから呼ぶ、Switch的なメソッド
- (NSArray *)p_generateClassesWithPath:(NSString *)path
{
    NSDictionary *jsonDictionary = [self p_loadJsonWithPath:path];
    NSArray *classNames = [jsonDictionary allKeys];
    
    NSMutableArray *generatedClasses = [NSMutableArray new];
    for (int i=0; i < [jsonDictionary count]; i++) {
        NSString *className = classNames[i];
        Class generateCls = [self p_generateClassWithName:className properties:jsonDictionary[className]];
        [generatedClasses addObject:generateCls];
    }
    return [generatedClasses copy];
}

// pathを渡すとjsonを読み込んでNSDictionaryを返してくれるメソッド
- (NSDictionary *)p_loadJsonWithPath:(NSString *)path
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:path ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];

    return jsonResponse;
}

// クラス名とNSArrayを渡すとClassを作って返してくれるメソッド
- (Class)p_generateClassWithName:(NSString *)name properties:(NSArray *)properties
{
    Class cls = objc_getClass(name.UTF8String);
    if (!cls) {
        // clsがまだない場合
        cls = objc_allocateClassPair(NSObject.class, name.UTF8String, 0);
        objc_registerClassPair(cls);
        // 作ったclsにpropertyを追加していく
        for (NSString *propertyName in properties) {
            @autoreleasepool {
                objc_property_attribute_t type = { "T", "@\"NSString\"" };
                objc_property_attribute_t ownership = { "C", "" }; // C = copy
                objc_property_attribute_t backingivar  = { "V", "_privateName" };
                objc_property_attribute_t attrs[] = { type, ownership, backingivar };
                class_addProperty(cls, propertyName.UTF8String, attrs, 3);
            }
        }
    }
    
    return cls;
}

@end
