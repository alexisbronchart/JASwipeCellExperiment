//
//  JASwipeCell.m
//  SwipeCellText
//
//  Created by Alexis Bronchart on 21/11/13.
//  Copyright (c) 2013 Alexis Bronchart. All rights reserved.
//

#import "JASwipeCell.h"

NSString *const JACellShouldHideMenuNotification = @"JACellShouldHideMenuNotification";

#define kMenuWidth 148.0f

@interface JASwipeCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JASwipeCell

@synthesize scrollView, scrollableContentView, menuView, isShowingMenu;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initializeCell];
    }
    
    return self;
}

- (void) awakeFromNib {
	[super awakeFromNib];
    
	[self initializeCell];
}

- (void) initializeCell {
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.menuView = [UIView new];
    self.menuView.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuView.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.menuView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[menuView(148)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(menuView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[menuView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(menuView)]];
    
    
    self.scrollView = [UIScrollView new];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	self.scrollView.delegate = self;
	self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, kMenuWidth);
    self.scrollView.exclusiveTouch = NO;
	
	[self.contentView addSubview:self.scrollView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)]];
    
    
    self.scrollableContentView = [UIView new];
    self.scrollableContentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollableContentView.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:self.scrollableContentView];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollableContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollableContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollableContentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollableContentView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollableContentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollableContentView)]];
    
    
    self.isShowingMenu = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenuOptions) name:JACellShouldHideMenuNotification object:nil];
}


#pragma mark - Private Methods

- (void) hideMenuOptions {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    self.isShowingMenu = NO;
}

- (void) showMenuOptions {
    
    if (!self.editing) {
        
        [self.scrollView setContentOffset:CGPointMake(kMenuWidth, 0) animated:YES];
        self.isShowingMenu = YES;
    }
}

- (void) toggleMenu {

    if (self.isShowingMenu) {
        
        [self hideMenuOptions];
        
    } else {
        
        [self showMenuOptions];
    }
}


#pragma mark - Overridden Methods

- (void) prepareForReuse {
	[super prepareForReuse];
	
    [self.scrollView setContentOffset:CGPointZero animated:NO];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
    
	self.scrollView.scrollEnabled = !self.editing;
    
    [self hideMenuOptions];
}


#pragma mark - Scroll view delegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.scrollView.contentOffset.x < 0) {
        
        self.scrollView.contentOffset = CGPointZero;
    }
    
    if (self.scrollView.contentOffset.x >= kMenuWidth) {
        
        [self.contentView bringSubviewToFront:self.menuView];
        
    } else if (self.scrollView.contentOffset.x < kMenuWidth) {
        
        [self.contentView sendSubviewToBack:self.menuView];
    }
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (self.scrollView.contentOffset.x > kMenuWidth/2) {
        
        targetContentOffset->x = kMenuWidth;
        
    } else {
        
        *targetContentOffset = CGPointZero;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointZero animated:YES];
        });
    }
}


@end

#undef kMenuWidth
