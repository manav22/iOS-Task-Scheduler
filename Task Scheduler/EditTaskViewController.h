//
//  EditTaskViewController.h
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "taskModelClass.h"

@protocol EditTaskViewControllerDelegate <NSObject>

@required
-(void)Save;

@end

@interface EditTaskViewController : UIViewController  <UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescTextField;

@property (strong, nonatomic) IBOutlet UIDatePicker *dueDatePicker;

@property(strong, nonatomic) taskModelClass *editTask;
@property(weak, nonatomic)id <EditTaskViewControllerDelegate> delegate;

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;

@end
