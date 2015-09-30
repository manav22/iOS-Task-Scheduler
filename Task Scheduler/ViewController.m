//
//  ViewController.m
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark- Lazy instantiations of properties

-(NSMutableArray *)addedNewTasks
{
    if(!_addedNewTasks)
    {
        _addedNewTasks=[[NSMutableArray alloc]init];
    }
    return _addedNewTasks;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.taskTableView.delegate = self;
    self.taskTableView.dataSource = self;
    
    NSArray *taskObjectsAsPropertyLists = [[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY];
    for (NSDictionary *dictionary in taskObjectsAsPropertyLists) {
        taskModelClass *task = [self taskObjectsForDictionary:dictionary];
        [self.addedNewTasks addObject:task];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.addedNewTasks count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    taskModelClass *task = [self.addedNewTasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.taskTitle;

    NSDate *date= task.taskDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFormatDate = [formatter stringFromDate:date];

    cell.detailTextLabel.text = stringFormatDate;
    BOOL isGreater = [self isDateGreaterThanCurrentDate:date and:[NSDate date]];
    if (task.istaskCompleted)
        cell.backgroundColor = [UIColor greenColor];
    else if (isGreater)
        cell.backgroundColor = [UIColor yellowColor];
    else
        cell.backgroundColor = [UIColor redColor];
    
    

    return cell;
}

#pragma mark- Table View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    taskModelClass *task = [self.addedNewTasks objectAtIndex:indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES ;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.addedNewTasks removeObjectAtIndex:indexPath.row];
        NSMutableArray *newtaskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
        [newtaskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:newtaskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.taskTableView reloadData];
  
        
    }
    
}
// Reordering
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    taskModelClass *sourcetask = [self.addedNewTasks objectAtIndex:sourceIndexPath.row];

    [self.addedNewTasks removeObjectAtIndex:sourceIndexPath.row];
    [self.addedNewTasks insertObject:sourcetask atIndex:destinationIndexPath.row];

    [self persistNewTaskPosition];
    
}
// Accessory Button
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailedTaskViewContoller" sender:indexPath];
}
#pragma mark- AddTaskViewController Delegate
//Receives the newTask object as an argument, we'll add this object to the mutable array created by the lazy instantiation in this method
-(void)didAddTask:(taskModelClass *)task
{
    [self.addedNewTasks addObject:task];
    
    //Let's save the array with the added object here using NSUserDefaults. We need to create a mutable array that will point to the array returned by the NSUserDefaults. Since NSUserDefaults stores just properties, we name it as taskObjectsAsPropertyLists
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
    //Since the first time our taskObjectsAsPropertyLists array won't have any object saved, so the very first time the value returned by NSUserDefaults will be nil. So let's just overcome that issue. We'll do it using if statement.
    if(!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    //Now let's add objects to this array using addObject method. Because, we need to make a property list to add it to NSUserDefaults array to save it or synchronize it later, so we need a helper method over here which does that job for us. Follow the helper method pragma mark.
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectsAsPropertyLists:task]]; // helper method used
    
    //save the array to NSUserDefaults with the key as used before when initialization.
    [[NSUserDefaults standardUserDefaults]setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.taskTableView reloadData];

}
-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//So this method is used to  generate a dictionary. We name it same as the mutable array 'coz it's to be used by that array.
#pragma mark- helper method
-(NSDictionary *)taskObjectsAsPropertyLists:(taskModelClass *)task
{
    NSDictionary *dictionary=@{TASK_TITLE: task.taskTitle,
                               TASK_DESCRIPTION: task.taskDescription,
                               TASK_DATE: task.taskDate,
                               TASK_COMPLETION: @(task.istaskCompleted)
                               };
    return dictionary;
}

//This method will be used to add the object to the array for displaying in table view after retrieval from the NSUserDefaults (saved earlier using the key: TASK_OBJECTS_KEY)
-(taskModelClass *)taskObjectsForDictionary: (NSDictionary *)dictionary
{
    taskModelClass *task = [[taskModelClass alloc]initWithData:dictionary];
    return task;
}
-(BOOL)isDateGreaterThanCurrentDate:(NSDate*)date and:(NSDate*)currentDate
{
    int time_interval1 = [date timeIntervalSince1970];
    int currentDate_time_interval = [currentDate timeIntervalSince1970];
    if (time_interval1 > currentDate_time_interval)
        return YES;
    else
        return NO;
}

-(void)updateCompletionOfTask:(taskModelClass *)task forIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
    if(!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if(task.istaskCompleted == YES)task.istaskCompleted = NO;
    else task.istaskCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectsAsPropertyLists:task] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [self.taskTableView reloadData];
    
}
-(void)persistNewTaskPosition
{
    NSMutableArray *newOrderTasksObject = [[NSMutableArray alloc]init];
    
    
    for (taskModelClass *task in self.addedNewTasks) {
        [newOrderTasksObject addObject:[self taskObjectsAsPropertyLists:task]];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:newOrderTasksObject forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

}
#pragma mark- action methods

- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender {
    if (self.taskTableView.editing == YES) [self.taskTableView setEditing:NO animated:YES];
    else [self.taskTableView setEditing:YES animated:YES];
}

- (IBAction)addTaskBaButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:[UIBarButtonItem class]];
}

#pragma mark- prepareForSegue Method

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[DetailedTaskViewController class]]) {
            NSIndexPath *path = sender;
            taskModelClass *selectedTask;
            DetailedTaskViewController *detailedTaskVC = segue.destinationViewController;
            selectedTask = self.addedNewTasks[path.row];
            detailedTaskVC.task = selectedTask;
            detailedTaskVC.delegate = self;
        }
    }
}
#pragma mark- DetailedTaskViewController Delegate
-(void)didSave
{
    [self persistNewTaskPosition];
    [self.taskTableView reloadData];
}
@end
