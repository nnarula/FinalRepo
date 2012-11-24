//
//  bPFlipsideViewController.m
//  bP
//
//  Created by ios on 05/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import "bPFlipsideViewController.h"

@interface bPFlipsideViewController ()

@end

@implementation bPFlipsideViewController

@synthesize entries;
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

- (void)viewDidLoad


{
    entries=[[NSMutableArray alloc]init];
    [self openDB];
    
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM sumary"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            // char *field1=(char *) sqlite3_column_text(statement, 0);
          //  NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
            
            char *field2=(char *) sqlite3_column_text(statement, 1);
            NSString *field2Str=[[ NSString alloc]initWithUTF8String:field2];
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
                                 
            
            
            NSString *str= [[NSString alloc] initWithFormat:@"%@/%@-%@", field2Str,field3Str,field4Str];
            [entries addObject:str];
            
            
        }
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}
#pragma mark -Table View Data source
-(NSInteger) numberOfSectionInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *myTitle=[[NSString alloc]initWithFormat:@"BP history"];
    return myTitle;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [entries count];
    NSLog(@" %d entries count",[entries count]);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    static NSString *cellIdentifier =@"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];


    cell.textLabel.text=[self.entries objectAtIndex:indexPath.row];
    return cell;

}


    
    -(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if (editingStyle==UITableViewCellEditingStyleDelete) {
            //bPFlipsideViewController *bp =[entries objectAtIndex:indexPath.row];
            NSString* abc = [entries objectAtIndex:indexPath.row];
            NSLog(@"Deleted %@" , abc);

           // NSString *search = @"%d/";
           // NSString *sub = [abc substringFromIndex:NSMaxRange([abc rangeOfString:search])];
           // NSLog(@"removed :%@",sub );
  
     //  NSString *theNewString = [abc substringFromIndex:[abc rangeOfString:@"%d/"].location];
       // NSLog(@"substring is :%@",theNewString);

      
           NSString *match = @"/";
           
            NSString *preTel;
          //  NSString *postTel;

            NSScanner *scanner = [NSScanner scannerWithString:abc];
          ////  NSScanner *scanner = [NSScanner scannerWithString:string];
          [scanner scanUpToString:match intoString:&preTel];
            
            [scanner scanString:match intoString:nil];
            //postTel = [string substringFromIndex:scanner.scanLocation];
            
           NSLog(@"preTel: %@", preTel);
           // NSLog(@"postTel: %@", postTel);
            
            
            [self deleteData:[NSString stringWithFormat:@"DELETE  FROM sumary WHERE systolic IS '%s'",
                              [preTel
                               UTF8String  ]]];
            [entries removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            
            
            
        }
    }
    
    -(void)deleteData:(NSString *)deleteQuery
    {
        char *error;
        if (sqlite3_exec(db, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK); {
            NSLog(@"person deleted");
            
        }
        
        
    }

    
@end
    
    
    
    
    
    
    
    
    
    
