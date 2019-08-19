//
//  FMTableViewCellProtocol.h
//  YXGJSJ
//
//  Created by wushiye on 2019/7/29.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMTableViewCellProtocol <NSObject>
@optional

/** 设置子views */
- (void)fm_setupSubviews;
/** 绑定ViewModel */
- (void)fm_bindViewModel;

@end

NS_ASSUME_NONNULL_END
