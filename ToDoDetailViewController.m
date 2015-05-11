//
//  ToDoDetailViewController.m
//  TODOLesson8
//
//  Created by Vasily on 07.05.15.
//  Copyright (c) 2015 Vasily Filippov. All rights reserved.
//

#import "ToDoDetailViewController.h"

@interface ToDoDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField; //подписываем указатель на объект

- (IBAction)save_Action:(id)sender; // подписываем кнопку Сохранить

- (IBAction)datePicker_Action:(UIDatePicker *)sender; // подписываем датапикер

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@property (strong, nonatomic) NSDate * date_New_Event;


@end

@implementation ToDoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datePicker.minimumDate = [NSDate date]; // устанавливаем минимальную дату равную текущему времени и дате
    
    if (self.isNewEvent) {
        [self.textField becomeFirstResponder]; //поднимает клавиатуру, если новое сообщение
    }
    else {
        self.textField.text = self.string_EventItem;
        
        self.textField.userInteractionEnabled = NO; //не поднимается клавиатура в случае, если переходим в окно детализации
        
        self.datePicker.userInteractionEnabled = NO; //так же блокируем барабан с датой
         
        [self performSelector:@selector(set_Date_Current_Event) withObject:nil afterDelay:0.5]; //задержка вращения барабана
    }
    
    
}


- (void) set_Date_Current_Event {
    
    [self.datePicker setDate:self.date_Current_Event animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void) set_Notification {
    //переформатируем дату эвента в нужный для нас формат:
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"dd.MMMM.yyyy HH:mm";
    NSString * string_Date = [format stringFromDate:self.date_New_Event];
    
    //устанавливаем то, что должно сохраняться по нажатию кнопки "Сохранить":
    UILocalNotification * notif = [[UILocalNotification alloc]init];
    
    //корректировать дату в зависимости от текущей тайм-зоны:
    notif.fireDate = self.date_New_Event;
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.alertBody = self.textField.text; //из поля ввода текста
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                           self.textField.text, @"event",
                           string_Date, @"data_event", nil];
    notif.userInfo = dict;
    notif.soundName = UILocalNotificationDefaultSoundName; //устанавливаем звук события
    notif.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1; //счетчик сообщений
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
    //чтобы таблица обновлялась после добавления нового элемента:
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewEvent" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (IBAction)save_Action:(id)sender {
    //заглушка на случай, если пользователь не установил дату и время:
    if (!self.date_New_Event) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"ВНИМАНИЕ!" message:@"Установите дату и время." delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"Давай реще!!!", nil];
        [alert show];
    }
    //заглушка на случай, если пользователь не ввел текст:
    else if ([self.textField.text length] == 0){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"ВНИМАНИЕ!" message:@"Напишите текст напоминания." delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"Давай реще!!!", nil];
        [alert show];
    }
    else {
        [self set_Notification];
    }
    
    
}

- (IBAction)datePicker_Action:(UIDatePicker *)sender {
    
    
    self.date_New_Event = sender.date; //устанавливаем дату эвента равной дате на барабане
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    
    return YES;
}



@end
