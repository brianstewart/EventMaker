#import "NewEventViewController.h"
#import "Event.h"

@implementation NewEventViewController {
    NSDateFormatter *_dateFormatter;
    BOOL _showingDatePicker;
    BOOL _startDateSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a date formatter for converting dates into strings and such
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateStyle = NSDateFormatterLongStyle;
    _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    // Setup default dates for the start and end
    // The start date is the next five minute interval
    // The end date is an hour after the start
    _startDate.text = [_dateFormatter stringFromDate:[NSDate date]];
    _endDate.text = [_dateFormatter stringFromDate:hourFromDate([NSDate date], YES)];
    
    // We are not showing the date picker at the beginning
    _showingDatePicker = NO;
}

- (void)viewDidUnload {
    [self setNameTextField:nil];
    [self setDatePicker:nil];
    [self setStartDate:nil];
    [self setEndDate:nil];
    [super viewDidUnload];
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != 0) {
        _startDateSelected = (indexPath.section == 1) ? YES : NO; // Check which date was selected
        if (!_showingDatePicker) {
            [_nameTextField resignFirstResponder];
            _showingDatePicker = YES;
            _datePicker.hidden = NO;
            _datePicker.frame = CGRectMake(_datePicker.frame.origin.x,
                                           _datePicker.frame.origin.y + 400,
                                           _datePicker.frame.size.width,
                                           _datePicker.frame.size.height);
            [UIView animateWithDuration:0.3 animations:^{
                _datePicker.frame = CGRectMake(_datePicker.frame.origin.x,
                                          _datePicker.frame.origin.y - 400,
                                          _datePicker.frame.size.width,
                                          _datePicker.frame.size.height);
            }];
        } else {
            if (indexPath.section == 1) // Selected start date
                [_datePicker setDate:[_dateFormatter dateFromString:_startDate.text] animated:YES];
            else // Selected end date
                [_datePicker setDate:[_dateFormatter dateFromString:_endDate.text] animated:YES];
        }
    }
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_showingDatePicker) {
        _showingDatePicker = NO;
        _datePicker.hidden = YES;
    }
}

#pragma mark - Actions
- (IBAction)done:(id)sender {
    NSDate *start = [_dateFormatter dateFromString:_startDate.text];
    NSDate *end = [_dateFormatter dateFromString:_endDate.text];
    
//    // Don't save if the start date if before now
//    if ([start earlierDate:[NSDate date]] == start) {
//        [[[BSAlert alloc] initWithTitle:@"No thanks" message:@"You cannot start before now" delegate:nil
//                      cancelButtonTitle:@"Alright!" otherButtonTitles:nil] show];
//        return;
//    }
    
    // Don't save if the end date is before the start
    if ([start laterDate:end] == start) {
        [[[BSAlert alloc] initWithTitle:@"No thanks" message:@"The start date must be before the end date" delegate:nil
                      cancelButtonTitle:@"Alright!" otherButtonTitles:nil] show];
        return;
    }
    
    // Don't save if event isn't named
    if ([_nameTextField.text isEqualToString:@""]) {
        [[[BSAlert alloc] initWithTitle:@"No thanks" message:@"You must name your event" delegate:nil
                      cancelButtonTitle:@"Cool beans" otherButtonTitles:nil] show];
        return;
    }
    
    // Dismiss the view and give the event to the delegate
    [self dismissModalViewControllerAnimated:YES];
    Event *event = [[Event alloc] initEventWithName:_nameTextField.text startDate:start andEndDate:end];
    [_delegate newEventViewControllerDidFinishEvent:event];
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [_delegate newEventViewControllerDidCancel];
}

- (IBAction)dateChanged:(id)sender {
    if (_startDateSelected)
        _startDate.text = [_dateFormatter stringFromDate:_datePicker.date];
    else
        _endDate.text = [_dateFormatter stringFromDate:_datePicker.date];
}
@end
