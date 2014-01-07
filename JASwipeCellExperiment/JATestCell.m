//
//  JATestCell.m
//  JASwipeCellExperiment
//
//  Created by Alexis Bronchart on 07/01/14.
//  Copyright (c) 2014 Jafar. All rights reserved.
//

#import "JATestCell.h"

@implementation JATestCell

@synthesize oloLabel;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initialize];
    }
    
    return self;
}

- (void) awakeFromNib {
	[super awakeFromNib];
    
	[self initialize];
}

- (void) initialize {
    
    self.oloLabel = [UILabel new];
    self.oloLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.scrollableContentView addSubview:self.oloLabel];
    
    [self.scrollableContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[oloLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(oloLabel)]];
    [self.scrollableContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[oloLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(oloLabel)]];
}

@end
