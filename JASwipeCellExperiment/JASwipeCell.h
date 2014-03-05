//
//  JASwipeCell.h
//  SwipeCellText
//
//  Created by Alexis Bronchart on 21/11/13.
//  Copyright (c) 2013 Alexis Bronchart. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const JACellShouldHideMenuNotification;

@class JASwipeCell;

@protocol JASwipeCellDelegate <NSObject>

@optional
- (void)menuDidOpenForCell:(JASwipeCell *)cell;
- (void)menuDidCloseForCell:(JASwipeCell *)cell;

@end

@interface JASwipeCell : UITableViewCell

@property (nonatomic, weak) id<JASwipeCellDelegate> swipeCellDelegate;

@property (nonatomic, strong) UIView *scrollableContentView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, assign) BOOL isShowingMenu;

- (void) toggleMenu;

@end
