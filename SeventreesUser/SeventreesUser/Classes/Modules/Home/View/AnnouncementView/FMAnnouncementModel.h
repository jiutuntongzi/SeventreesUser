//
//  FMAnnouncementModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMAnnouncementModel : FMModel

@property (nonatomic, copy) NSString *action;

@property (nonatomic, assign) NSNumber *createdId;

@property (nonatomic, assign) NSNumber *ID;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, copy) NSString *createdDateTime;

@property (nonatomic, assign) NSNumber *lastModifiedId;

@property (nonatomic, copy) NSString *lastModifiedDateTime;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *jumpType;

@property (nonatomic, copy) NSDictionary *extra;

@end

