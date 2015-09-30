//
//  EditTaskViewController.m
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskTextField.text = self.editTask.taskTitle;
    self.taskDescTextField.text = self.editTask.taskDescription;
    self.dueDatePicker.date = self.editTask.taskDate;

    self.taskDescTextField.delegate = self;
    self.taskTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender {
    [self updateTask];
    [self.delegate Save];
}

#pragma mark- helper method
-(void)updateTask
{
    self.editTask.taskTitle = self.taskTextField.text;
    self.editTask.taskDescription = self.taskDescTextField.text;
    self.editTask.taskDate = self.dueDatePicker.date;
}

#pragma mark- UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTextField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.taskTextField.text isEqualToString:@"\n"]) {
        return NO;
    }
    return YES;
}



@end
