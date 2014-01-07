//
//  JAViewController.h
//  SwipeCellText
//
//  Created by Alexis Bronchart on 21/11/13.
//  Copyright (c) 2013 Jafar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
