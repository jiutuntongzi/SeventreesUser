//
//  FMViewProtocol.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#ifndef FMViewProtocol_h
#define FMViewProtocol_h

@protocol FMViewModelProtocol; // 协议引用

@protocol FMViewProtocol <NSObject>
@optional

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel;

/** 设置子views */
- (void)fm_setupSubviews;

/** 生成布局约束 */
//- (void)fm_makeConstraints;

/** 绑定KVO观察 */
- (void)fm_bindObserver;

/** 绑定ViewModel */
- (void)fm_bindViewModel;

@end


#endif /* FMViewProtocol_h */
