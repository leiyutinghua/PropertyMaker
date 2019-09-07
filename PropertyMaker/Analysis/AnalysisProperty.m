//
//  AnalysisProperty.m
//  PropertyMaker
//
//  Created by 123 on 2019/9/6.
//  Copyright © 2019 123. All rights reserved.
//

#import "AnalysisProperty.h"

@implementation AnalysisProperty

// MARK: - Public Methods
- (BOOL)keyChange {
    return self.showKey && ![self.showKey isEqualToString:self.originalKey];
}

// MARK: - NSObject
- (NSString *)description {
    if (self.convertString) {
        return [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;\n", self.showKey ? : self.originalKey];
    }
    
    if ([self.value isKindOfClass:[NSNull class]] || [self.value isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;\n", self.showKey ? : self.originalKey];
    } else if ([self.value isKindOfClass:[NSNumber class]]) {
        if (strcmp([self.value objCType], @encode(float)) == 0 || strcmp([self.value objCType], @encode(double)) == 0) {
            return [NSString stringWithFormat:@"@property (nonatomic, assign) CGFloat %@;\n", self.showKey ? : self.originalKey];
        } else if (strcmp([self.value objCType], @encode(int)) == 0) {
            return [NSString stringWithFormat:@"@property (nonatomic, assign) int %@;\n", self.showKey ? : self.originalKey];
        } else if (strcmp([self.value objCType], @encode(long)) == 0) {
            return [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;\n", self.showKey ? : self.originalKey];
        } else if (strcmp([self.value objCType], @encode(BOOL)) == 0) {
            return [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;\n", self.showKey ? : self.originalKey];
        }
    }
    return @"";
}

@end
