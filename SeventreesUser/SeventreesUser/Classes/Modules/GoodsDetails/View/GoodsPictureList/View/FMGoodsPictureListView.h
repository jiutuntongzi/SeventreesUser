//
//  FMGoodsPictureListView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

#import "FMGoodsPictureListViewModel.h"


extern const CGFloat FMGoodsPictureListViewRowHeight;

@interface FMGoodsPictureListView : FMView

@property (nonatomic, strong) FMGoodsPictureListViewModel *viewModel;

@end
