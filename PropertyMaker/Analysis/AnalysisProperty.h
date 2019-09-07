//
//  AnalysisProperty.h
//  PropertyMaker
//
//  Created by 123 on 2019/9/6.
//  Copyright © 2019 123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnalysisProperty : NSObject

@property (nonatomic, copy) NSString *originalKey;
@property (nonatomic, copy) NSString *showKey;
@property (nonatomic, strong) id value;

@property (nonatomic, assign) BOOL convertString;
@property (nonatomic, readonly, assign) BOOL keyChange;
/** 将要更改为的新key */
@property (nonatomic, copy, nullable) NSString *changeNewKey;

@end

NS_ASSUME_NONNULL_END
