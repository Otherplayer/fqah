//
//  FQAHTableView.h
//  fqah
//
//  Created by __无邪_ on 15/11/19.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <UIKit/UIKit.h>
@class    FQAHTableView;
@protocol FQAHTableViewDataSource;
@protocol FQAHTableViewDelegate;


@interface FQAHTableView : UIView
@property (nonatomic, weak) id<FQAHTableViewDataSource> dataSource;
@property (nonatomic, weak) id<FQAHTableViewDelegate>   delegate;

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (__kindof UITableViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)reloadData;/***  刷新数据*/


@end



////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
@protocol FQAHTableViewDataSource <NSObject>
@required
- (NSInteger)tableView:(FQAHTableView *)tableView numberOfItemsInSection:(NSInteger)section;
- (__kindof UITableViewCell *)tableView:(FQAHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(FQAHTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol FQAHTableViewDelegate <NSObject>
@optional
- (void)tableView:(FQAHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
