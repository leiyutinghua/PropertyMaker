//
//  AnalysisSetting.h
//  PropertyMaker
//
//  Created by 123 on 2019/9/5.
//  Copyright © 2019 123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnalysisSetting : NSObject

/** 默认设置，保存在NSUserDefaults中 */
+ (instancetype)defaultSetting;

/** 是否驼峰 */
@property (nonatomic, assign) BOOL isHump;
/** 是否全部设为NSString */
@property (nonatomic, assign) BOOL isAllNSString;

@end

NS_ASSUME_NONNULL_END
