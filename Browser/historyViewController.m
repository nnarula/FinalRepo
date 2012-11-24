//
//  historyViewController.m
//  Browser
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import "historyViewController.h"

@interface historyViewController ()

@end
@implementation historyViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//[historyViewController *hav=[[historyViewController alloc]init];
@synthesize entries;
-(NSString *)filePath{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    return[[paths objectAtIndex:0]stringByAppendingPathComponent:@"historyDB.sql"];
}
-(void) openDB{
    if (sqlite3_open([[self filePath] UTF8String], &historyDB)!= SQLITE_OK) {
        sqlite3_close(historyDB);
        NSAssert(0, @"Database Failed to Open");
        
    }else{
        NSLog(@"Database Opened");
    }
}

- (void)viewDidLoad


{
    
    entries=[[NSMutableArray alloc]init];
    [self openDB];
    
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM browsehistory"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(historyDB, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            // char *field1=(char *) sqlite3_column_text(statement, 0);
            //  NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
            
            char *field1=(char *) sqlite3_column_text(statement, 0);
            NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
            
            char *field2=(char *) sqlite3_column_text(statement, 1);
            NSString *field2Str=[[ NSString alloc]initWithUTF8String:field2];
            
     
            
            
            
            NSString *str= [[NSString alloc] initWithFormat:@"%@=%@", field1Str,field2Str];
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




#pragma mark -Table View Data source
-(NSInteger) numberOfSectionInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *myTitle=[[NSString alloc]initWithFormat:@" Web History"];
    return myTitle;
}
-(NSInteger *)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [entries count];
    NSLog(@" %d entries count",[entries count]);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    static NSString *cellIdentifier =@"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *xyz=[self.entries objectAtIndex:indexPath.row];
    
    NSString *match = @"=";
    
    NSString *preTelTest;
    NSString *postTel;
    
    NSScanner *scanner = [NSScanner scannerWithString:xyz];
    //  NSScanner *scanner = [NSScanner scannerWithString:xyz];
    [scanner scanUpToString:match intoString:&preTelTest];
    
    [scanner scanString:match intoString:nil];
    postTel = [xyz substringFromIndex:scanner.scanLocation];
    
    NSLog(@"preTelTest: %@", preTelTest);
    NSLog(@"postTel: %@", postTel);
    

    cell.textLabel.text=postTel;
   // cell.textLabel.text=[self.entries objectAtIndex:indexPath.row];

    cell.detailTextLabel.text=preTelTest;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier =@"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *historyAddress=cell.textLabel.text=[entries objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"history address is :%@",historyAddress);
    NSString *match = @"=";
    
    NSString *historyPreTel;
    // NSString *historyPostTel;
    
    NSScanner *scanner = [NSScanner scannerWithString:historyAddress];
    ////  NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToString:match intoString:&historyPreTel];
    
    [scanner scanString:match intoString:nil];
    addressString = [historyAddress substringFromIndex:scanner.scanLocation];
   // BrowserViewController *bvc;
    NSLog(@" history post Tel: %@", addressString);
    NSString *valueToSave = addressString;
    [[NSUserDefaults standardUserDefaults]
     setObject:valueToSave forKey:@"webaddress"];
    NSLog(@"value is :%@",valueToSave);
 //  [BrowserViewController enterAddress ];
    
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
        
        
        NSString *match = @"=";
        
        NSString *preTel;
        //  NSString *postTel;
        
        NSScanner *scanner = [NSScanner scannerWithString:abc];
        ////  NSScanner *scanner = [NSScanner scannerWithString:string];
        [scanner scanUpToString:match intoString:&preTel];
        
        [scanner scanString:match intoString:nil];
        //postTel = [string substringFromIndex:scanner.scanLocation];
        
        NSLog(@"preTel: %@", preTel);
        // NSLog(@"postTel: %@", postTel);
        
        
        [self deleteData:[NSString stringWithFormat:@"DELETE  FROM browsehistory WHERE date IS '%@'",
                          preTel
                           ]];
        [entries removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath ] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
    }
}

-(void)deleteData:(NSString *)deleteQuery
{
    char *error;
    if (sqlite3_exec(historyDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK); {
        NSLog(@"Page Deleted");
        
    }
    
    
}


- (IBAction)backTOBrowser:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
 
    }
@end
