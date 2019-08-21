//
//  FMCollectionViewCellProtocol.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMCollectionViewCellProtocol <NSObject>
@optional

/** 设置子views */
- (void)fm_setupSubviews;
/** 绑定ViewModel */
- (void)fm_bindViewModel;

@end

NS_ASSUME_NONNULL_END
