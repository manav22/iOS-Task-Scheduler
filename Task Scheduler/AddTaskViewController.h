//
//  AddTaskViewController.h
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "taskModelClass.h"

@protocol AddTaskViewControllerDelegate <NSObject>
@required
-(void)didCancel;
-(void)didAddTask:(taskModelClass *)task;
@end

@interface AddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id<AddTaskViewControllerDelegate> delegate; //delegate property


@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
