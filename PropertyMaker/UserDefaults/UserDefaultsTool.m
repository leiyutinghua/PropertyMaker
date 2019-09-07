//
//  UserDefaultsTool.m
//  PropertyMaker
//
//  Created by 雷雨庭花 on 2019/9/7.
//  Copyright © 2019 123. All rights reserved.
//

#import "UserDefaultsTool.h"
#import "AnalysisSetting.h"

/** 属性设置 */
static NSString * const settingKey = @"settingKey";

@implementation UserDefaultsTool

// MARK: - Public Methods
+ (void)setAnalysisSetting:(AnalysisSetting *)setting {
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:setting requiringSecureCoding:YES error:&error];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:settingKey];
    if (error) {
        NSLog(@"%@", error);
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (AnalysisSetting *)getAnalysisSetting {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:settingKey];
    if (!data) {
        return [AnalysisSetting new];
    }
    NSError *error;
    AnalysisSetting *setting = [NSKeyedUnarchiver unarchivedObjectOfClass:[AnalysisSetting class] fromData:data error:&error];
    return setting;
}

@end
