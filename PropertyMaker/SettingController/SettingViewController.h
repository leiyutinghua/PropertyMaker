//
//  SettingViewController.h
//  PropertyMaker
//
//  Created by 123 on 2019/9/6.
//  Copyright © 2019 123. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class SettingViewController;
@protocol SettingViewControllerDelegate <NSObject>

- (void)commitPropertyChange:(SettingViewController *)settingController;

@end

@class AnalysisProperty;
@interface SettingViewController : NSViewController

@property (nonatomic, weak) id<SettingViewControllerDelegate> delegate;
- (void)updateContents:(NSArray<AnalysisProperty *> *)contents;

@end

NS_ASSUME_NONNULL_END
