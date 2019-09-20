//
//  FMMenuBarView.h
//  TheWaistcoat
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMMenuBarView : UIView

@property (nonatomic, copy) NSArray *dataSources;

- (instancetype)initWithFrame:(CGRect)frame dataSources:(NSArray<NSDictionary *> *)dataSources didSelectItemHandler:(void(^)(NSDictionary *info))selectItemCallback;

- (void)didSelectItemByIndex:(NSUInteger)index;

@end
