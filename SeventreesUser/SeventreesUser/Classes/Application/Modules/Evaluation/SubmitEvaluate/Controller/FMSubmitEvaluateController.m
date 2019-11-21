//
//  FMSubmitEvaluateController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSubmitEvaluateController.h"
#import "FMEvaluateStarView.h"

#import "FMImageEyeCell.h"
#import "FMEvaluateViewModel.h"

#import <ZLPhotoBrowser/ZLPhotoBrowser.h>

@interface FMSubmitEvaluateController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cameraViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UIView *starContentView;
@property (weak, nonatomic) IBOutlet FMEvaluateStarView *starView;

@end

@implementation FMSubmitEvaluateController

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _starView = FMEvaluateStarView.cv_viewFromNibLoad();
    _starView.starValue = 0; // 默认无星
    [_starContentView addSubview:_starView];
    
    _textView.delegate = self;
 
    [self setupCollectionView];
    [self setupCollectionViewFlowLayout];
}

- (void)setupCollectionView {
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[FMImageEyeCell class] forCellWithReuseIdentifier:NSStringFromClass([FMImageEyeCell class])];
}

- (void)setupCollectionViewFlowLayout {
    // 每组Cell四边的边距
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; // 水流方向(横向)
    /// itemCell 宽/高
    CGFloat itemWH = 85.f; // 固定值
    _flowLayout.minimumInteritemSpacing = 0.f;
    // 行间距）
    _flowLayout.minimumLineSpacing = 10.f;
    _flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    _cameraViewWidthConstraint.constant = 100.f; // 三张图变0.f
    
    [[_cameraButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.view.cv_endEditing();  DLog(@"点了 从系统相册获取图片");
        
        ZLPhotoActionSheet *photoSheet = [[ZLPhotoActionSheet alloc] init];
        // 相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
        photoSheet.configuration.maxSelectCount = 5;
        photoSheet.configuration.maxPreviewCount = 10;
        //如调用的方法无sender参数，则该参数必传
        photoSheet.sender = self;
        // 选择回调
        [photoSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            // your codes
            
        }];
        
        // 调用相册
        [photoSheet showPreviewAnimated:YES];
    }];
}

- (void)fm_makeConstraints {
    [_starView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_starContentView);
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"商品评价";
}

- (void)fm_refreshData {
    
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMImageEyeCell *cell = FMImageEyeCell.ccc_cellReuseForCollectionViewIndexPath(collectionView, indexPath);
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DLog(@"indexPath == %@", indexPath);
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = textView.hasText;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    _placeholderLabel.hidden = textView.hasText;
}
- (void)textViewDidChange:(UITextView *)textView {
    _placeholderLabel.hidden = textView.hasText;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"销毁了");
}

@end
