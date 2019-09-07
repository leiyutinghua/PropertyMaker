//
//  AnalysisSetting.m
//  PropertyMaker
//
//  Created by 123 on 2019/9/5.
//  Copyright © 2019 123. All rights reserved.
//

#import "AnalysisSetting.h"
#import "UserDefaultsTool.h"

@interface AnalysisSetting () <NSCoding, NSSecureCoding>

@end

static NSString * const hump = @"isHump";
static NSString * const allString = @"isAllNSString";

@implementation AnalysisSetting

// MARK: - Init
- (instancetype)init {
    if (self = [super init]) {
        _isHump = NO;
        _isAllNSString = NO;
    }
    return self;
}

// MARK: - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _isHump = [aDecoder decodeBoolForKey:hump];
        _isAllNSString = [aDecoder decodeBoolForKey:allString];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:self.isHump forKey:hump];
    [aCoder encodeBool:self.isAllNSString forKey:allString];
}

// MARK: - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}

// MARK: - Public Methods
+ (instancetype)defaultSetting {
    return [UserDefaultsTool getAnalysisSetting];
}

- (void)setIsHump:(BOOL)isHump {
    _isHump = isHump;
    [UserDefaultsTool setAnalysisSetting:self];
}

- (void)setIsAllNSString:(BOOL)isAllNSString {
    _isAllNSString = isAllNSString;
    [UserDefaultsTool setAnalysisSetting:self];
}

@end
