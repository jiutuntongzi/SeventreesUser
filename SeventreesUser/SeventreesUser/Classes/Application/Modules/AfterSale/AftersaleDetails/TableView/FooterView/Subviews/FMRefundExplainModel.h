//
//  FMRefundExplainModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/27.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMRefundExplainModel : FMModel

/** "reason": "不想要了",    --退款原因 */
@property (nonatomic, copy) NSString *reason;

/** "amount": 100,    --退款金额/申请金额 */
@property (nonatomic, strong) NSNumber *amount;

/** "createdDateTime": "2019-10-15 16:03:28",    --申请时间 */
@property (nonatomic, copy) NSString *createdDateTime;

/** "serialNumber": 1571126608534,    --退款编号 */
@property (nonatomic, strong) NSNumber *serialNumber;

/** "distribution": "圆通速递",    --物流公司 */
@property (nonatomic, copy) NSString *logisticsCompany;

/** "district": "244560557177",    --快递/物流单号 */
@property (nonatomic, copy) NSString *district;

@end

