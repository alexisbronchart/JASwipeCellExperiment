//
//  JASwipeCell.h
//  SwipeCellText
//
//  Created by Alexis Bronchart on 21/11/13.
//  Copyright (c) 2013 Alexis Bronchart. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const JACellShouldHideMenuNotification;

@interface JASwipeCell : UITableViewCell

@property (nonatomic, strong) UIView *scrollableContentView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, assign) BOOL isShowingMenu;

- (void) toggleMenu;

@end
