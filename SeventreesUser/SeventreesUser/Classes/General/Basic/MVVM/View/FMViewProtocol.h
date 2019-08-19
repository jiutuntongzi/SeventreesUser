//
//  FMViewProtocol.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#ifndef FMViewProtocol_h
#define FMViewProtocol_h

@protocol FMViewModelProtocol; // 引用ViewModel协议

@protocol FMViewProtocol <NSObject>
@optional

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel;

/** 设置子views */
- (void)fm_setupSubviews;
/** 绑定ViewModel */
- (void)fm_bindViewModel;

@end


#endif /* FMViewProtocol_h */
