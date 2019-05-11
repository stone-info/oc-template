//
//  SearchSectionController.m
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SearchSectionController.h"
#import "SearchCell.h"

@interface SearchSectionController () <UISearchBarDelegate, IGListScrollDelegate>


@end

@implementation SearchSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.scrollDelegate = self;
  }
  return self;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 44);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {

  SearchCell *cell = [self.collectionContext dequeueReusableCellOfClass:SearchCell.class forSectionController:self atIndex:index];

  cell.searchBar.delegate = self;

  return cell;
}

#pragma mark - <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  [self.delegate sectionController:self didChangeText:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
  [self.delegate sectionController:self didChangeText:searchBar.text];
}

- (void)listAdapter:(IGListAdapter *)listAdapter didScrollSectionController:(IGListSectionController *)sectionController {

  SearchCell *cell = [self.collectionContext cellForItemAtIndex:0 sectionController:self];
  [cell.searchBar resignFirstResponder];

}

- (void)listAdapter:(IGListAdapter *)listAdapter willBeginDraggingSectionController:(IGListSectionController *)sectionController {

}

- (void)listAdapter:(IGListAdapter *)listAdapter didEndDraggingSectionController:(IGListSectionController *)sectionController willDecelerate:(BOOL)decelerate {

}


// - (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//   return YES;
// }
//
// - (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//
// }
//
// - (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
//
//   return YES;
// }
//
// - (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//
// }
//
// - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
// }
//
// - (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//   return YES;
// }
//
// - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//
// }
//
// - (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
//
// }
//
// - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//
// }
//
// - (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
//
// }
//
// - (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
//
// }


@end
