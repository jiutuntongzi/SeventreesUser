//
//  FMShopDetailView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/3.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMGoodsDetailsPageStyle.h"

#import "FMGoodsDetailsModel.h"

extern const CGFloat FMShopDetailViewHeight;

extern const CGFloat FMSpellShopDetailViewHeight;

@interface FMShopDetailView : FMView

@property (nonatomic, copy) NSArray<FMGoodsDetailsShowImagesModel *> *pictureModels;

@property (nonatomic, strong) FMGoodsDetailsOrdinaryGoodsMsgModel *detailsModel;

@end
