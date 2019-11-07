//
//  FMCollectionViewCellProtocol.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#ifndef FMCollectionViewCellProtocol_h
#define FMCollectionViewCellProtocol_h

@protocol FMViewModelProtocol; // 协议引用

@protocol FMCollectionViewCellProtocol <NSObject>
@optional

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel;

/** 设置子views */
- (void)fm_setupSubviews;

/** 生成布局约束 */
- (void)fm_makeConstraints;

/** 绑定KVO观察 */
- (void)fm_bindObserver;

/** 绑定ViewModel */
- (void)fm_bindViewModel;

@end

#endif /** FMCollectionViewCellProtocol.h */
