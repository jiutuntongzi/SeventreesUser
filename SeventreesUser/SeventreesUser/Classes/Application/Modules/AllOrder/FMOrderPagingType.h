//
//  FMOrderPagingType.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#ifndef FMOrderPagingType_h
#define FMOrderPagingType_h

enum FMOrderPagingType {
    FMOrderPagingTypeAll = 0,
    FMOrderPagingTypeWaitPay,
    FMOrderPagingTypeWaitSend,
    FMOrderPagingTypeWaitReceive,
    FMOrderPagingTypeWaitEvaluate,
//    FMOrderPagingTypeWaitCanceled
};

extern enum FMOrderPagingType global_orderType;

#endif /* FMOrderPagingType_h */
