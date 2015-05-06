//
//  DataViewController.h
//  Chart
//
//  Created by Morgan Wilde on 04/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import CoreData;
@import UIKit;
#import "DataTableViewCell.h"

@interface DataViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

- (void)textFieldDidDelete:(UITextField *)textField;
- (void)prepareForEditing:(DataTableViewCell *)cell;

@end
