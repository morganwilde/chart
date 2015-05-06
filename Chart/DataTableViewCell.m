//
//  DataTableViewCell.m
//  Chart
//
//  Created by Morgan Wilde on 05/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "DataTableViewCell.h"
#import "DataViewController.h"
#import "TableViewEnhanced.h"

@implementation DataTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)borderView
{
    if (!_borderView) {
        _borderView = [[UIView alloc] init];
    }
    return _borderView;
}

- (void)layoutSubviews
{
    if (![self.contentView.subviews containsObject:self.borderView]) {
        CGFloat borderHeight = 0.5;
        CGFloat padding = 8;
        CGRect borderFrame = CGRectMake(self.frame.origin.x + padding,
                                        self.frame.size.height - borderHeight,
                                        self.frame.size.width - 2*padding,
                                        borderHeight);
        self.borderView.frame = borderFrame;
        self.borderView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        
        [self.contentView addSubview:self.borderView];
    }
    
    [super layoutSubviews];
}

- (void)hideBorder
{
    self.borderView.hidden = true;
}

- (void)showBorder
{
    self.borderView.hidden = false;
}

- (IBAction)actionEdit:(UIButton *)sender {
    TableViewEnhanced *tableView = (TableViewEnhanced *)((TableViewEnhanced *)self.superview).delegate;
    DataViewController *controller = (DataViewController *)tableView.delegate;
    [controller prepareForEditing:self];
}

@end
