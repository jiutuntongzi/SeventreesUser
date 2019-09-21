//
//  FMViewControllerProtocol.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#ifndef FMViewControllerProtocol_h
#define FMViewControllerProtocol_h

@protocol FMViewModelProtocol; // 引用ViewModel协议


@protocol FMViewControllerProtocol <NSObject>
@optional

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel;

/** 绑定ViewModel */
- (void)fm_bindViewModel;

/** 添加子views */
- (void)fm_addSubviews;

/** 添加布局约束 */
- (void)fm_makeConstraints;

/** 设置导航栏 */
- (void)fm_setupNavbar;

/** 刷新数据 */
- (void)fm_refreshData;

@end

#endif /* FMViewControllerProtocol_h */
