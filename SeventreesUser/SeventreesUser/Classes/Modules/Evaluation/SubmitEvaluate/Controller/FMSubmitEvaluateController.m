//
//  FMSubmitEvaluateController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSubmitEvaluateController.h"
#import "FMImageEyeCell.h"
#import "FMEvaluateViewModel.h"

@interface FMSubmitEvaluateController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UILabel *placeholderLabel;

@end

@implementation FMSubmitEvaluateController

#pragma mark - System Functions

- (void)setupCollectionViewFlowLayout {
    // 每组Cell四边的边距
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; // 水流方向(横向)
    
    /// itemCell 宽/高
    CGFloat itemWH = FMImageEyeCellSize + 5.f; // 固定值
    _flowLayout.minimumInteritemSpacing = 0.f;
    // 行间距）
    _flowLayout.minimumLineSpacing = 10.f;
    _flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _textView.delegate = self;
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[FMImageEyeCell class] forCellWithReuseIdentifier:NSStringFromClass([FMImageEyeCell class])];
    
    [self setupCollectionViewFlowLayout];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_makeConstraints {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"商品评价";
}

- (void)fm_refreshData {
    
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
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
