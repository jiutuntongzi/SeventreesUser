//
//  PagingCalculateUtility.h
//  YXGJSJ
//
//  Created by wushiye on 2019/7/25.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSArray* (^NetworkRequestDataHandler)(id result);

typedef void (^FinishReloadTABHandler)(NSArray *entitys);

@interface PagingCalculateUtility : NSObject

- (instancetype)initWithPageNo:(NSUInteger)pageNo limit:(NSUInteger)limit uriPath:(NSString *)uriPath params:(NSDictionary *)params requestDataHandler:(NetworkRequestDataHandler)requestDataHandler finishReloadData:(FinishReloadTABHandler)finishReloadDataHandler;

/** 处理下拉刷新 */
- (void)execPullDownRefresh;

/** 处理上拉加载 */
- (void)execUpPullLoad;

@end

