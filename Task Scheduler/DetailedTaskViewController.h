//
//  DetailedTaskViewController.h
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "taskModelClass.h"
#import "EditTaskViewController.h"

@protocol DetailedTaskViewControllerDelegate <NSObject>

@required
-(void)didSave;

@end

@interface DetailedTaskViewController : UIViewController <EditTaskViewControllerDelegate>

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskLabel;

@property (strong, nonatomic) taskModelClass *task; //to display the the task info from view controller

@property (weak, nonatomic)id <DetailedTaskViewControllerDelegate> delegate;

@end
