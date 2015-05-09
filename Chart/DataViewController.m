//
//  DataViewController.m
//  Chart
//
//  Created by Morgan Wilde on 04/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "DataViewController.h"
#import "DataTableViewCell.h"
#import "AppDelegate.h"
#import "Data.h"
#import "Data+DataInterface.h"
#import "TextFieldEnhanced.h"
#import "TableViewEnhanced.h"
#import "ChartViewController.h"

@interface DataViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet TableViewEnhanced *tableView;
@property (weak, nonatomic) IBOutlet UIView *tableHeaderParentView;
@property (weak, nonatomic) IBOutlet UIView *formParentView;
@property (weak, nonatomic) IBOutlet UIView *formHeaderParentView;
@property (weak, nonatomic) IBOutlet UILabel *formLabel;
@property (weak, nonatomic) IBOutlet UIButton *formDeleteButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *addDatePickerView;
@property (weak, nonatomic) IBOutlet TextFieldEnhanced *addValueField;
@property (weak, nonatomic) IBOutlet TextFieldEnhanced *addGoalField;
@property (weak, nonatomic) IBOutlet UIButton *addSaveButton;
@property (weak, nonatomic) IBOutlet UIView *addDatePickerParentView;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;

// Core data properties
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSArray *dataArray;

// Properties
@property (nonatomic) CGFloat positionYPadding;
@property (nonatomic) TextFieldEnhanced *clearCandidateField;
@property (nonatomic) TextFieldEnhanced *activeField;
@property (nonatomic) BOOL editingCell;
@property (nonatomic) DataTableViewCell *cellBeingEdited;

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Table view setup
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.rowHeight = 30;
    
    // New Data form setup
    self.addValueField.delegate = self;
    self.addGoalField.delegate = self;
    self.errorMessageLabel.text = @"";
    
    // Keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    // Styling
    self.addDatePickerParentView.layer.cornerRadius = 5;
    self.addDatePickerParentView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    self.addDatePickerParentView.layer.borderWidth = 0.5;
    
    NSLog(@"here");
}

- (void)viewDidLayoutSubviews
{
    // Styling
    CALayer *tableHeaderBorderLayer = [CALayer layer];
    tableHeaderBorderLayer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    tableHeaderBorderLayer.borderWidth = 0.5;
    tableHeaderBorderLayer.frame = CGRectMake(-1,
                                              -1,
                                              self.tableHeaderParentView.frame.size.width + 2,
                                              self.tableHeaderParentView.frame.size.height + 1);
    [self.tableHeaderParentView.layer addSublayer:tableHeaderBorderLayer];
    
    CALayer *formLabelBorderLayer = [CALayer layer];
    formLabelBorderLayer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    formLabelBorderLayer.borderWidth = 0.5;
    formLabelBorderLayer.frame = CGRectMake(-1,
                                            -1,
                                            self.formHeaderParentView.frame.size.width + 2,
                                            self.formHeaderParentView.frame.size.height + 1);
    [self.formHeaderParentView.layer addSublayer:formLabelBorderLayer];
    
    [super viewDidLayoutSubviews];
}

#pragma mark - Table methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (DataTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell"];
    Data *data = self.dataArray[indexPath.row];
    
    if (cell == nil) {
        cell = [[DataTableViewCell alloc] init];
    }
    
    // Fill the cell
    cell.valueLabel.text = [NSString stringWithFormat:@"%d", data.value.intValue];
    cell.goalLabel.text = [NSString stringWithFormat:@"%d", data.goal.intValue];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", [data dateFormatted]];
    cell.date = data.date;
    
    if (indexPath.row == [self.dataArray count] - 2) {
        [cell showBorder];
    }
    if (indexPath.row == [self.dataArray count] - 1) {
        [cell hideBorder];
    }
    
    return cell;
}

- (void)tableViewScrollToBottom
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1
                                                inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:true];
}

- (void)tableViewScrollBackToCell:(NSUInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row
                                                inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:true];
}

#pragma mark - Getters

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.managedObjectContext;
    }
    return _managedObjectContext;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Data"
                                                             inManagedObjectContext:self.managedObjectContext];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:true];
        fetchRequest.sortDescriptors = @[sortDescriptor];
        fetchRequest.entity = entityDescription;
        NSError *fetchError;
        _dataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
        
        // Update chart controller
        ChartViewController *chartController = (ChartViewController *)self.tabBarController.viewControllers[0];
        chartController.dataArray = nil;
        [chartController viewDidLoad];
    }
    return _dataArray;
}

- (void)setEditingCell:(BOOL)editingCell
{
    _editingCell = editingCell;
    if (editingCell) {
        self.formLabel.text = @"Edit data";
        [self.addSaveButton setTitle:@"Update" forState:UIControlStateNormal];
        self.formDeleteButton.hidden = false;
        [self clearErrorMessage];
    } else {
        self.formLabel.text = @"Add data";
        [self.addSaveButton setTitle:@"Save" forState:UIControlStateNormal];
        self.cellBeingEdited = nil;
        self.formDeleteButton.hidden = true;
    }
}

#pragma mark - Text fields

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInformation = [notification userInfo];
    CGSize keyboardSize = [userInformation[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat offsetYVisible = self.formParentView.frame.origin.y - self.tableView.contentOffset.y;
    CGFloat formBottomY = offsetYVisible + self.formParentView.frame.size.height + self.tableView.frame.origin.y;
    CGFloat keyboardOffsetY = self.view.frame.size.height - keyboardSize.height;
    
    if (formBottomY > keyboardOffsetY) {
        self.positionYPadding = formBottomY - keyboardOffsetY;
    }
    
    self.view.frame = CGRectMake(0, -self.positionYPadding, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (BOOL)textFieldShouldBeginEditing:(TextFieldEnhanced *)textField
{
    self.activeField = textField;
    if ([textField.text isEqualToString:@"Value"] ||
        [textField.text isEqualToString:@"Goal"]) {
        textField.text = @"";
    }
    [self clearErrorMessage];
    
    return true;
}

- (void)textFieldDidDelete:(TextFieldEnhanced *)textField
{
    if (textField.text.length == 0) {
        if (self.clearCandidateField == nil) {
            self.clearCandidateField = textField;
        } else if (self.clearCandidateField == textField) {
            if (textField == self.addValueField) {
                textField.text = @"Value";
            } else if (textField == self.addGoalField) {
                textField.text = @"Goal";
            }
            [textField resignFirstResponder];
            self.clearCandidateField = nil;
        }
    } else {
        self.clearCandidateField = nil;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // If the user didn't provide any data, reset the label
    if (textField.text.length == 0) {
        if (textField == self.addValueField) {
            textField.text = @"Value";
        } else if (textField == self.addGoalField) {
            textField.text = @"Goal";
        }
    }
    
    [textField resignFirstResponder];
    self.activeField = nil;
    return true;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint location = [touch locationInView:self.formParentView];
    if (![self.addValueField pointInside:location withEvent:nil] &&
        ![self.addGoalField pointInside:location withEvent:nil]) {
        [self textFieldShouldReturn:self.activeField];
    }
}

- (void)setActiveField:(TextFieldEnhanced *)activeField
{
    if (_activeField.text.length == 0) {
        if (_activeField == self.addValueField) {
            _activeField.text = @"Value";
        } else if (_activeField == self.addGoalField) {
            _activeField.text = @"Goal";
        }
    }
    _activeField = activeField;
}

#pragma mark - Actions

- (IBAction)actionAdd:(UIButton *)sender
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *valueNumber = [formatter numberFromString:self.addValueField.text];
    NSNumber *goalNumber = [formatter numberFromString:self.addGoalField.text];
    NSDate *date = self.addDatePickerView.date;
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    NSDate *dateRounded = [calender dateFromComponents:dateComponents];
    
    if (!valueNumber) {
        [self showError:@"Value incorrect"];
    } else if (!goalNumber || goalNumber.integerValue < 0) {
        [self showError:@"Goal incorrect"];
    } else {
        // Check if date already exists
        Data *existingData = [self fetchDataWith:dateRounded];
        if (existingData && ![dateRounded isEqualToDate:self.cellBeingEdited.date]) {
            [self showError:@"Date exists"];
        } else {
            if (self.editingCell && existingData) {
                existingData.value = valueNumber;
                existingData.goal = goalNumber;
                existingData.date = dateRounded;
            } else {
                Data *data = [NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:self.managedObjectContext];
                data.value = valueNumber;
                data.goal = goalNumber;
                data.date = dateRounded;
            }

            [self finilizeEditing];
            [self tableViewScrollToBottom];
        }
    }
    
}

- (IBAction)actionDelete:(UIButton *)sender {
    NSDate *date = self.addDatePickerView.date;
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    NSDate *dateRounded = [calender dateFromComponents:dateComponents];

    Data *existingData = [self fetchDataWith:dateRounded];
    
    NSUInteger index = [self.dataArray indexOfObject:existingData];
    if (index > 0) {
        index--;
    }
    
    [self.managedObjectContext deleteObject:existingData];
    [self finilizeEditing];
    if (index != NSNotFound && self.dataArray.count > 0) {
        [self tableViewScrollBackToCell:index];
    }
}

- (void)finilizeEditing
{
    // Update form
    self.addValueField.text = @"Value";
    self.addGoalField.text = @"Goal";
    self.editingCell = false;
    [self clearErrorMessage];
    
    // Update table
    self.dataArray = nil;
    [self textFieldShouldReturn:self.activeField];
    [self.tableView reloadData];
    
    NSError *saveError;
    if (![self.managedObjectContext save:&saveError]) {
        NSLog(@"save error");
    }
}

- (void)prepareForEditing:(DataTableViewCell *)cell
{
    self.cellBeingEdited = cell;
    self.editingCell = true;
    self.addValueField.text = cell.valueLabel.text;
    self.addGoalField.text = cell.goalLabel.text;
    self.addDatePickerView.date = cell.date;
    [self tableViewScrollToBottom];
}

- (void)showError:(NSString *)message
{
    self.errorMessageLabel.text = message;
}

- (void)clearErrorMessage
{
    self.errorMessageLabel.text = @"";
}

#pragma mark - Data retrieval

- (Data *)fetchDataWith:(NSDate *)date
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Data"
                                                         inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@", date];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;
    NSError *fetchError;
    NSArray *dataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    
    if (dataArray.count == 1) {
        return (Data *)dataArray[0];
    }
    return nil;
}

@end
