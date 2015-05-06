//
//  DataTableViewCell.h
//  Chart
//
//  Created by Morgan Wilde on 05/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataTableViewCell : UITableViewCell

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

// Properties
@property (nonatomic) UIView *borderView;
@property (nonatomic) NSDate *date;

- (void)hideBorder;
- (void)showBorder;
- (IBAction)actionEdit:(UIButton *)sender;

@end
