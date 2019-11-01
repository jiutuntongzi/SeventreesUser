//
//  SearchBarView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "SearchBarView.h"

@interface SearchBarView () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchBarView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_searchBar becomeFirstResponder];
}

#pragma mark ——— <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchText = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar canBecomeFirstResponder];
    if (_searchTouchCallback) _searchTouchCallback(_searchText);
}

@end
