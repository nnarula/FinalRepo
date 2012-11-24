//
//  bPMainViewController.m
//  bP
//
//  Created by ios on 05/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import "bPMainViewController.h"

@interface bPMainViewController ()

@end

@implementation bPMainViewController


-(NSString *)filePath{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    return[[paths objectAtIndex:0]stringByAppendingPathComponent:@"db.sql"];

}



-(void) openDB{
    if (sqlite3_open([[self filePath] UTF8String], &db)!= SQLITE_OK) {
        sqlite3_close(db);
 NSAssert(0, @"Database Failed to Open");
        
    }else{
        NSLog(@"Database Opened");
    }
}



-(void)createTable:(NSString *)tableName
        withField1:(NSString *)field1
        withField2:(NSString *)field2
        withField3:(NSString *)field3
        withField4:(NSString *)field4{
    
    
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@'TEXT PRIMARY KEY ,'%@' INTEGER,'%@' INTEGER,'%@' TEXT); ",tableName,field1,field2,field3,field4];
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"could not create table");
        
    }else{
        NSLog(@"table created");
        
    }
    
}
- (IBAction)didEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)saveEntry:(id)sender {

    int systolic=[self.systolicText.text intValue ];
    int diastolic=[self.diastolicText .text intValue];
    NSString *comments= self.commentsText.text ;
    NSDate *theDate=[NSDate date];
    
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO sumary('theDate','systolic','diastolic','comments')VALUES ('%@','%d','%d','%@')",theDate,systolic,diastolic,comments];
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        
        sqlite3_close(db);
        NSAssert(0, @"could not update table");
        
    }else{
        NSLog(@"table Updated");
        
    }self.systolicText.text=@"";
    self.diastolicText.text=@"";
    self.commentsText.text=@"";
   
    
    
}

-(void)viewDidLoad
{   [self openDB];
    [self createTable:@"sumary" withField1:@"theDate" withField2:@"systolic" withField3:@"diastolic" withField4:@"comments"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(bPFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
