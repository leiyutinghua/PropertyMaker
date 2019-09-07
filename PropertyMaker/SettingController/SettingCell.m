//
//  SettingCell.m
//  PropertyMaker
//
//  Created by 123 on 2019/9/6.
//  Copyright © 2019 123. All rights reserved.
//

#import "SettingCell.h"

#import "AnalysisProperty.h"

@interface SettingCell () <NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *originalLabel;

@property (nonatomic, strong) AnalysisProperty *property;

@end

@implementation SettingCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEnd:) name:NSControlTextDidChangeNotification object:self.originalLabel];
}

// MARK: - 通知
- (void)textBeginEnd:(NSNotification *)sender {
    NSTextField *textField = (NSTextField *)sender.object;
    self.property.changeNewKey = textField.stringValue;
}

// MARK: - Public Methods
- (void)cellWithTitle:(NSString *)title editable:(BOOL)editable {
    self.originalLabel.stringValue = title;
    self.originalLabel.editable = editable;
}

- (void)updateProperty:(AnalysisProperty *)property {
    self.property = property;
}

@end
