//
//  taskModelClass.m
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import "taskModelClass.h"

@implementation taskModelClass
-(id)init
{
    self = [self initWithData:nil];
    return self;
}

-(id)initWithData:(NSDictionary *)data
{
        self= [super init];
    
    if(self){
            self.taskTitle = data[TASK_TITLE];
            self.taskDescription = data[TASK_DESCRIPTION];
            self.taskDate = data[TASK_DATE];
            self.istaskCompleted = [data[TASK_COMPLETION] boolValue];
        }
    
        return self;
}

@end
