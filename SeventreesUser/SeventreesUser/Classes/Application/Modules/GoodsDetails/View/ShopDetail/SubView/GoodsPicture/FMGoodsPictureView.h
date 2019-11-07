//
//  FMGoodsPictureView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/3.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMGoodsDetailsModel.h"

extern const CGFloat FMGoodsPictureViewHeight;

@interface FMGoodsPictureView : FMView

@property (nonatomic, copy) NSArray<FMGoodsDetailsShowImagesModel *> *pictureModels;

@end
