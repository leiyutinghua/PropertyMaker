//
//  JSONAnalysis.m
//  PropertyMaker
//
//  Created by 123 on 2019/9/5.
//  Copyright © 2019 123. All rights reserved.
//

#import "JSONAnalysis.h"

#import "AnalysisProperty.h"

NSString * const propertyKey = @"propertyKey";
NSString * const keyValueKey = @"keyValueKey";

@interface JSONAnalysis ()

@property (nonatomic, strong) AnalysisSetting *setting;

// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableDictionary *changeKeysDic;

@end

@implementation JSONAnalysis

// MARK: - Init
- (instancetype)initWithSetting:(AnalysisSetting *)setting {
    if (self = [super init]) {
        self.setting = setting;
    }
    return self;
}

// MARK: - Public Methods
- (NSDictionary *)generatorPropertyTextWithJson:(NSString *)jsonStr error:(NSError * _Nullable __autoreleasing *)error {
    [self.changeKeysDic removeAllObjects];
    [self.dataSource removeAllObjects];
    
    if ([jsonStr isEqualToString:@""]) {
        *error = [NSError errorWithDomain:@"property.com" code:-100 userInfo:@{}];
        return @{};
    }
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:error];
    if (*error) {
        return @{};
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        *error = [NSError errorWithDomain:@"property.com" code:-100 userInfo:@{}];
        return @{};
    }
    NSMutableString *content = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        AnalysisProperty *property = [AnalysisProperty new];
        property.originalKey = key;
        property.value = obj;
        
        if (self.setting.isHump) {
            // 驼峰
            property.showKey = [self transformToHumpStringWith:key];
        }
        
        if (self.setting.isAllNSString) {
            // 全部为string
            property.convertString = YES;
        } else {
            property.convertString = NO;
        }
        
        if (property.keyChange) {
            [self.changeKeysDic setObject:property.originalKey forKey:property.showKey];
        }
        
        [self.dataSource addObject:property];
        
        [content appendString:property.description];
    }];
    
    NSDictionary *result = [NSMutableDictionary dictionary];
    [result setValue:content forKey:propertyKey];
    [result setValue:[self changeKeyTransform] forKey:keyValueKey];
    return result;
}

- (NSDictionary *)updateGenerator {
    [self.changeKeysDic removeAllObjects];
    NSMutableString *content = [NSMutableString string];
    for (AnalysisProperty *property in self.dataSource) {
         [content appendString:property.description];
        
        if (property.keyChange) {
            [self.changeKeysDic setObject:property.originalKey forKey:property.showKey];
        }
    }
    
    NSDictionary *result = [NSMutableDictionary dictionary];
    [result setValue:content forKey:propertyKey];
    [result setValue:[self changeKeyTransform] forKey:keyValueKey];
    return result;
}

// MARK: Getter
- (NSArray<AnalysisProperty *> *)contents {
    return self.dataSource;
}

// MARK: - Tools
// 下划线字符串转驼峰字符串
- (NSString *)transformToHumpStringWith:(NSString *)key {
    NSMutableString *mStr = [NSMutableString stringWithString:key];
    while ([mStr containsString:@"_"]) {
        NSRange range = [mStr rangeOfString:@"_"];
        if (range.location + 1 < [mStr length]) {
            char c = [mStr characterAtIndex:range.location + 1];
            [mStr replaceCharactersInRange:NSMakeRange(range.location, range.length + 1) withString:[[NSString stringWithFormat:@"%c", c] uppercaseString]];
        }
    }
    return mStr;
}

// 生成key值转换代码
- (NSString *)changeKeyTransform {
    NSMutableString *keyValueStr = [NSMutableString string];
    if (self.changeKeysDic.count > 0) {
        [keyValueStr appendString:@"// MARK: - ModelDicTransform\n- (NSDictionary *)propertyKeyReplaceWithValue {\n    return @{\n"];
        for (NSString *key in self.changeKeysDic) {
            [keyValueStr appendString:[NSString stringWithFormat:@"             @\"%@\": @\"%@\",\n", key, self.changeKeysDic[key]]];
        }
        [keyValueStr deleteCharactersInRange:NSMakeRange(keyValueStr.length - 2, 1)];
        [keyValueStr appendString:@"             };\n}"];
    }
    return keyValueStr;
}

// MARK: - 懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableDictionary *)changeKeysDic {
    if (!_changeKeysDic) {
        self.changeKeysDic = [NSMutableDictionary dictionary];
    }
    return _changeKeysDic;
}

@end
