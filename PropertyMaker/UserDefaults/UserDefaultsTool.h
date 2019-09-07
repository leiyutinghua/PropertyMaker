//
//  UserDefaultsTool.h
//  PropertyMaker
//
//  Created by 雷雨庭花 on 2019/9/7.
//  Copyright © 2019 123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AnalysisSetting;
@interface UserDefaultsTool : NSObject

+ (void)setAnalysisSetting:(AnalysisSetting *)setting;
+ (AnalysisSetting *)getAnalysisSetting;

@end

NS_ASSUME_NONNULL_END
