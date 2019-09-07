//
//  SettingCell.h
//  PropertyMaker
//
//  Created by 123 on 2019/9/6.
//  Copyright © 2019 123. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class AnalysisProperty;
@interface SettingCell : NSTableCellView

- (void)cellWithTitle:(NSString *)title editable:(BOOL)editable;
- (void)updateProperty:(nullable AnalysisProperty *)property;

@end

NS_ASSUME_NONNULL_END
