//
//  MainMakerViewController.m
//  PropertyMaker
//
//  Created by 123 on 2019/9/5.
//  Copyright © 2019 123. All rights reserved.
//

#import "MainMakerViewController.h"

#import "SettingViewController.h"

#import "JSONAnalysis.h"

/** 页面跳转 */
// NSWindowController
// https://blog.csdn.net/lovechris00/article/details/77922445
// NSViewController
// https://www.jianshu.com/p/b6b30d38255e

@interface MainMakerViewController () <SettingViewControllerDelegate>

/** 原textView */
@property (unsafe_unretained) IBOutlet NSTextView *originTextView;
/** 生成property内容textView */
@property (unsafe_unretained) IBOutlet NSTextView *makerTextView;
/** 转换键值textView */
@property (unsafe_unretained) IBOutlet NSTextView *keyTransTextView;
@property (weak) IBOutlet NSButton *humpButton;
@property (weak) IBOutlet NSButton *allStringButton;
@property (weak) IBOutlet NSTextField *tipLabel;

/** 解析器 */
@property (nonatomic, strong) JSONAnalysis *analysis;

@end

@implementation MainMakerViewController

// MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSetting];
}

// MARK: 设置相关
- (void)loadSetting {
    // 禁用NSTextView引号转换
    self.originTextView.automaticQuoteSubstitutionEnabled = NO;
    // 设置setting
    AnalysisSetting *setting = [AnalysisSetting defaultSetting];
    if (setting.isAllNSString) {
        self.allStringButton.state = NSControlStateValueOn;
    } else {
        self.allStringButton.state = NSControlStateValueOff;
    }
    if (setting.isHump) {
        self.humpButton.state = NSControlStateValueOn;
    } else {
        self.humpButton.state = NSControlStateValueOff;
    }
    
    self.analysis = [[JSONAnalysis alloc] initWithSetting:setting];
}

// MARK: - Delegates
// MARK: SettingViewControllerDelegate
- (void)commitPropertyChange:(SettingViewController *)settingController {
    NSDictionary *result = [self.analysis updateGenerator];
    self.makerTextView.string = result[propertyKey];
    self.keyTransTextView.string = result[keyValueKey];
}

// MARK: - Setting Actions
- (IBAction)humpButtonAction:(NSButton *)sender {
    self.analysis.setting.isHump = sender.state == NSControlStateValueOn;
    [self generatorProperty];
}

- (IBAction)allStringButtonAction:(NSButton *)sender {
    self.analysis.setting.isAllNSString = sender.state == NSControlStateValueOn;
    [self generatorProperty];
}

// MARK: - Button Actions
// 生成属性
- (IBAction)generateButtonAction:(NSButton *)sender {
    [self generatorProperty];
}

// copy属性代码
- (IBAction)copyMakerButtonAction:(NSButton *)sender {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:self.makerTextView.string forType:NSPasteboardTypeString];
}

// copy key键值转换代码
- (IBAction)copyKeyTransButtonAction:(NSButton *)sender {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:self.keyTransTextView.string forType:NSPasteboardTypeString];
}

// 属性调整
- (IBAction)adjustButtonAction:(NSButton *)sender {
    // 跳转至设置页面
    SettingViewController *controller = [[NSStoryboard mainStoryboard] instantiateControllerWithIdentifier:@"SettingViewController"];
    controller.delegate = self;
    [controller updateContents:self.analysis.contents];
    [self presentViewControllerAsSheet:controller];
}

// MARK: - Private Methods
- (void)generatorProperty {
    NSError *error;
    NSDictionary *result = [self.analysis generatorPropertyTextWithJson:self.originTextView.string error:&error];
    if (error) {
        self.tipLabel.hidden = NO;
        return;
    }
    self.tipLabel.hidden = YES;
    self.makerTextView.string = result[propertyKey] ? : @"";
    self.keyTransTextView.string = result[keyValueKey] ? : @"";
}

@end
