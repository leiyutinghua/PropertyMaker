//
//  SettingViewController.m
//  PropertyMaker
//
//  Created by 123 on 2019/9/6.
//  Copyright © 2019 123. All rights reserved.
//

#import "SettingViewController.h"
#import "AnalysisProperty.h"

#import "SettingCell.h"

@interface SettingViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation SettingViewController

// MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

// MARK: - Public Methods
- (void)updateContents:(NSArray<AnalysisProperty *> *)contents {
    self.dataSource = [NSArray arrayWithArray:contents];
    [self.tableView reloadData];
}

// MARK: - NSTableViewDataSource, NSTableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    SettingCell *cell = [tableView makeViewWithIdentifier:@"SettingCell" owner:self];
    
    AnalysisProperty *property = self.dataSource[row];
    NSString *key = property.originalKey;
    BOOL editable = NO;
    if ([tableColumn.identifier isEqualToString:@"showKey"]) {
        // 显示key列
        key = property.showKey ? : property.originalKey;
        editable = YES;
        // 更新属性
        [cell updateProperty:property];
    }
    [cell cellWithTitle:key editable:editable];
    return cell;
}

// MARK: - Button Actions
- (IBAction)cancelButtonAction:(NSButton *)sender {
    for (AnalysisProperty *property in self.dataSource) {
        property.changeNewKey = nil;
    }
    [self dismissController:nil];
}

- (IBAction)commitButtonAction:(NSButton *)sender {
    for (AnalysisProperty *property in self.dataSource) {
        if (property.changeNewKey) {
            property.showKey = property.changeNewKey;
            property.changeNewKey = nil;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(commitPropertyChange:)]) {
        [self.delegate commitPropertyChange:self];
    }
    [self dismissController:nil];
}

@end
