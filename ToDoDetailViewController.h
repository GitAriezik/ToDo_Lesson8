//
//  ToDoDetailViewController.h
//  TODOLesson8
//
//  Created by Vasily on 07.05.15.
//  Copyright (c) 2015 Vasily Filippov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoDetailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) BOOL isNewEvent;
@property (nonatomic, strong) NSString * string_EventItem;
@property (nonatomic, strong) NSDate * date_Current_Event;

@end
