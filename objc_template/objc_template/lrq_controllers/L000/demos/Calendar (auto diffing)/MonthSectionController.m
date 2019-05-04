//
//  MonthSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.

#import "MonthSectionController.h"
#import "MonthTitleViewModel.h"
#import "Month.h"
#import "DayViewModel.h"
#import "CalendarDayCell.h"
#import "LabelCell.h"
#import "MonthTitleCell.h"

@interface MonthSectionController () <IGListBindingSectionControllerDataSource, IGListBindingSectionControllerSelectionDelegate>

@property (strong, nonatomic) NSNumber *selectedDay;

@end

@implementation MonthSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.selectedDay       = @-1;
    self.dataSource        = self;
    self.selectionDelegate = self;
  }
  return self;
}

#pragma mark - <IGListBindingSectionControllerDataSource>

- (NSArray<id <IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(id)object {

  if ([object isKindOfClass:[Month class]]) {
    Month *month = (Month *) object;

    NSDate *date = NSDate.new;

    NSInteger today = [NSCalendar.currentCalendar component:NSCalendarUnitDay fromDate:date];

    NSMutableArray<id <IGListDiffable>> *viewModels = [NSMutableArray array];

    [viewModels addObject:[MonthTitleViewModel.alloc initWithName:month.name]];

    for (NSInteger day = 1; day < (month.days.integerValue + 1); ++day) {
      DayViewModel *viewModel = [DayViewModel.alloc
        initWithDay:@(day)
        today:day == today
        selected:day == self.selectedDay.integerValue
        appointments:@(month.appointments[@(day)].count)];

      [viewModels addObject:viewModel];
    }

    NSArray<NSString *> *array = month.appointments[self.selectedDay];

    for (NSString *appointment in array) {
      [viewModels addObject:appointment];
    }

    return viewModels.copy;

  } else { return @[]; }
}

- (UICollectionViewCell <IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
  if ([viewModel isKindOfClass:[DayViewModel class]]) {
    return [self.collectionContext dequeueReusableCellOfClass:CalendarDayCell.class forSectionController:self atIndex:index];
  }

  if ([viewModel isKindOfClass:[MonthTitleViewModel class]]) {
    return [self.collectionContext dequeueReusableCellOfClass:MonthTitleCell.class forSectionController:self atIndex:index];
  }

  return [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];

}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index {

  CGFloat width = self.collectionContext.containerSize.width;

  if ([viewModel isKindOfClass:[DayViewModel class]]) {
    CGFloat square = width / 7.0;
    return CGSizeMake(square, square);
  }

  if ([viewModel isKindOfClass:[MonthTitleViewModel class]]) {
    return CGSizeMake(width, 30.0);
  }

  return CGSizeMake(width, 55.0);
}

#pragma mark - <IGListBindingSectionControllerSelectionDelegate>

- (void)sectionController:(IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(id)viewModel {

  if ([viewModel isKindOfClass:[DayViewModel class]]) {
    DayViewModel *dayViewModel = (DayViewModel *) viewModel;

    if (dayViewModel.day.integerValue == self.selectedDay.integerValue) {
      self.selectedDay = @(-1);
    } else {
      self.selectedDay = dayViewModel.day;
    }

    [self updateAnimated:YES completion:nil];
  }

}
@end
