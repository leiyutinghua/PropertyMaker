//
//  JSONAnalysis.h
//  PropertyMaker
//
//  Created by 123 on 2019/9/5.
//  Copyright © 2019 123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnalysisSetting.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const propertyKey;
extern NSString * const keyValueKey;

@class AnalysisProperty;
@interface JSONAnalysis : NSObject

- (instancetype)initWithSetting:(AnalysisSetting *)setting;

@property (nonatomic, readonly, strong) AnalysisSetting *setting;
@property (nonatomic, readonly, strong) NSArray<AnalysisProperty *> *contents;

- (NSDictionary *)generatorPropertyTextWithJson:(NSString *)jsonStr error:(NSError **)error;
- (NSDictionary *)updateGenerator;

@end

NS_ASSUME_NONNULL_END
