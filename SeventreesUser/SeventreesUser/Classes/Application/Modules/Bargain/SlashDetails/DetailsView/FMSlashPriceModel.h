//
//  FMSlashPriceModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMSlashPriceModel : FMModel

/** --当前价 */
@property (nonatomic, assign) CGFloat curPrice;
/** --优惠减价 */
@property (nonatomic, assign) CGFloat favourablePrice;
/** --最低价 */
@property (nonatomic, assign) CGFloat floorPrice;

@end

