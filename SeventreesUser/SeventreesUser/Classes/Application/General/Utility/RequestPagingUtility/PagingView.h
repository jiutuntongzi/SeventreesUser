//
//  PagingView.h
//  YXGJSJ
//
//  Created by wushiye on 2019/8/9.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkResultModel.h"

typedef NSArray* (^PVNetworkRequestDataHandler)(NetworkResultModel *resultModel);

typedef UITableViewCell* (^PVTableViewCellConfigHandler)(UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys);

typedef void (^PVTableViewCellDidSelectHandler)(id rowEntity);


@interface PagingView : UIView

@property (nonatomic, copy) NSArray *entitys;


/**
 初始化下拉/上拉分页表格

 @param limit 传0表示普通表格，不做分页处理
 @param uriPath 请求路径
 @param rowHeight cell行高，传0做自动估算行高
 @param params 请求体参数
 @param requestDataHandler 请求结果表格数据源处理，返回cell实体数组
 @param cellConfig Cell数据源配置
 @param cellDidSelectHandler 选中表格Cell事件处理
 @return PagingView
 */
- (instancetype)initWithLimit:(NSUInteger)limit uriPath:(NSString *)uriPath rowHeight:(CGFloat)rowHeight params:(NSDictionary * __nullable)params requestDataHandler:(PVNetworkRequestDataHandler)requestDataHandler cellConfig:(PVTableViewCellConfigHandler)cellConfig cellDidSelectHandler:(PVTableViewCellDidSelectHandler)cellDidSelectHandler;

- (void)requestData;

- (void)requestDataByParams:(NSDictionary *)params;

@end

