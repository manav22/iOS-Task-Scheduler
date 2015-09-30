//
//  taskModelClass.h
//  Task Scheduler
//
//  Created by Manav Pavitra Singh on 7/6/15.
//  Copyright (c) 2015 SJSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface taskModelClass : NSObject

@property (nonatomic, strong) NSString *taskTitle;
@property (nonatomic, strong) NSString *taskDescription;
@property (nonatomic, strong) NSDate *taskDate;
@property (nonatomic) BOOL istaskCompleted;

-(id)initWithData:(NSDictionary *)data;

@end
