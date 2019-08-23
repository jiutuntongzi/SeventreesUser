//
//	Brand.h
//
//	Create by 志伟 谌 on 7/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Brand : NSObject

@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, assign) NSInteger createId;
@property (nonatomic, strong) NSString * created;
@property (nonatomic, strong) NSString * depict;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * logoUrl;
@property (nonatomic, strong) NSString * modified;
@property (nonatomic, assign) NSInteger modifyId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * picUrl;
@property (nonatomic, strong) NSString * status;

@property (nonatomic,assign)CGFloat brandHeaderHeight;
@property (nonatomic,assign)CGFloat allExpandheight;//全部展开的高度
@property (nonatomic,assign)BOOL isExpand;//是否展开
@property (nonatomic,assign)BOOL isDownBtnHide; //是否隐藏下拉展开的按钮
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
