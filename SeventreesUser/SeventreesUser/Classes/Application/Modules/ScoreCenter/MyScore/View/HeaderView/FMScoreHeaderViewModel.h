//
//  FMScoreHeaderViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMScoreModel.h"

@interface FMScoreHeaderViewModel : FMViewModel

/** self. KVO */
@property (nonatomic, strong) FMScoreModel *scoreEntity;

//@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *nextPageSubject;


@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACCommand *requestSignInCommand;

@property (nonatomic, copy) NSString *webExplainURL;
@property (nonatomic, strong) RACCommand *requestWebExplainCommand;

@end

