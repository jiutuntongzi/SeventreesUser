//
//  PagingView.h
//  YXGJSJ
//
//  Created by wushiye on 2019/8/9.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSArray* (^PVNetworkRequestDataHandler)(NSDictionary *result);

typedef UITableViewCell* (^PVTableViewCellConfigHandler)(UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys);

typedef void (^PVTableViewCellDidSelectHandler)(id rowEntity);


@interface PagingView : UIView

- (instancetype)initWithLimit:(NSUInteger)limit uriPath:(NSString *)uriPath params:(NSDictionary *)params requestDataHandler:(PVNetworkRequestDataHandler)requestDataHandler cellConfig:(PVTableViewCellConfigHandler)cellConfig cellDidSelectHandler:(PVTableViewCellDidSelectHandler)cellDidSelectHandler;

@end

