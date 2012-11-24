//
//  bPMainViewController.h
//  bP
//
//  Created by ios on 05/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import "bPFlipsideViewController.h"
#import "sqlite3.h"
@interface bPMainViewController : UIViewController <bPFlipsideViewControllerDelegate>

{
    sqlite3 *db;
    
    
}
@property (strong  , nonatomic) IBOutlet UITextField *systolicText;
@property (strong, nonatomic) IBOutlet UITextField *diastolicText;
@property (strong, nonatomic) IBOutlet UITextField *commentsText;
@property(nonatomic,readonly)NSDate *currentDate;
- (IBAction)didEndOnExit:(id)sender;

- (IBAction)saveEntry:(id)sender;


-(NSString *)filePath;
-(void)openDB;
-(void)createTable:(NSString *)tableName
        withField1:(NSString *)field1
        withField2:(NSString *)field2
        withField3:(NSString *)field3
        withField4:(NSString *)field4;











@end
