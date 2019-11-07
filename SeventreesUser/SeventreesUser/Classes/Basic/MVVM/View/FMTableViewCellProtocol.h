//
//  FMTableViewCellProtocol.h
//  YXGJSJ
//
//  Created by wushiye on 2019/7/29.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#ifndef FMTableViewCellProtocol_h
#define FMTableViewCellProtocol_h

@protocol FMViewModelProtocol; // 协议引用

@protocol FMTableViewCellProtocol <NSObject>
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

#endif /* FMTableViewCellProtocol_h */
