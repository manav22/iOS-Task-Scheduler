//
//  ViewController.h
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DetailedTaskViewController.h"
@interface ViewController : UIViewController <AddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, DetailedTaskViewControllerDelegate> /*"conforms to AddTaskViewController protocol to act according to the Add Task and Cancel Buttons on AddTaskViewController scene*/

@property (strong, nonatomic) NSMutableArray *addedNewTasks; /*Array property for adding new Tasks returned by the helper method. The helper method returns the object of taskModelClass.*/
- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBaButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
@end

