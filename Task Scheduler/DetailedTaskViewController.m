//
//  DetailedTaskViewController.m
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "DetailedTaskViewController.h"
#import "EditTaskViewController.h"
@interface DetailedTaskViewController ()

@end

@implementation DetailedTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.task.taskTitle;
    self.taskLabel.text = self.task.taskDescription;
   
        NSDate *date = self.task.taskDate;
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"dd-MM-yy"];
        NSString *stringDate = [dateformatter stringFromDate:date];

    self.dateLabel.text = stringDate;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]) {
        EditTaskViewController *EditTaskVC = segue.destinationViewController;
        EditTaskVC.editTask = self.task;
        EditTaskVC.delegate = self;
    }
}


#pragma mark- EditTaskViewController Delegate
-(void)Save
{
    self.titleLabel.text = self.task.taskTitle;
    self.taskLabel.text = self.task.taskDescription;
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"dd-MM-yy"];
    NSString *stringDate = [dateformatter stringFromDate:self.task.taskDate];
    
    self.dateLabel.text = stringDate;
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didSave];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:[UIBarButtonItem class]];
}
@end
