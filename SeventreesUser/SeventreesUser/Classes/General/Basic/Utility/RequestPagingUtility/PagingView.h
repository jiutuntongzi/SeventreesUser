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

- (instancetype)initWithLimit:(NSUInteger)limit uriPath:(NSString *)uriPath rowHeight:(CGFloat)rowHeight params:(NSDictionary *)params requestDataHandler:(PVNetworkRequestDataHandler)requestDataHandler cellConfig:(PVTableViewCellConfigHandler)cellConfig cellDidSelectHandler:(PVTableViewCellDidSelectHandler)cellDidSelectHandler;

- (void)requestData;

@end

