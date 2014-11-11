//
//  ASNDynamicClasses.h
//  ASNDynamicClasses
//
//  Created by AsanoYuki on 2014/11/11.
//  Copyright (c) 2014年 AsanoYuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASNDynamicClasses : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSArray *generatedClasses;

// jsonへのパスを元にASNDynamicClassesインスタンスを作る
- (instancetype)initWithPath:(NSString *)path;

- (id)generateClass:(Class)cls;

@end
