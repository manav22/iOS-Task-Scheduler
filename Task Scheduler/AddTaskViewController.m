//
//  AddTaskViewController.m
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskDescTextView.delegate = self;
    self.taskNameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Method
/*This method returns an object of the task model class. This is just used to set up a new task when the user presses on Add Task Button. The addTaskButtonPressed action gets in work and points to an object of this class. It's like newTask = task object returned by this method. In short, both newTask and task variables point to the same object. */
-(taskModelClass *)returnNewTaskObject
{
    taskModelClass *task = [[taskModelClass alloc]init];
    task.taskTitle = self.taskNameTextField.text;
    task.taskDescription = self.taskDescTextView.text;
    task.taskDate = self.dueDatePicker.date;
    task.istaskCompleted = NO;
    return task;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//In this method after having an object from the helper method. It delegates to didAddTask protocol method, passes the newTask/task (since both points to same object as discussed above under Helper Method pragma mark) object returned by the helper method as an argument to didAddTask method.
- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    taskModelClass *newTask = [self returnNewTaskObject];
    [self.delegate didAddTask:newTask];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
}

#pragma mark- UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskNameTextField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.taskNameTextField.text isEqualToString:@"\n"]) {
        return NO;
    }
    return YES;
}



@end
