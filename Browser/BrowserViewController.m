//
//  BrowserViewController.m
//  Browser
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()


@end

@implementation BrowserViewController
@synthesize webView;
@synthesize address;
@synthesize activityIndicator;
@synthesize goButton;
@synthesize historyButton;
@synthesize mySwitch;

    
/*-(void)viewWillAppear:(BOOL)animated
{
    addressString = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"webaddress"];
    NSLog(@"adress string is %@:",addressString );
    address.text=addressString;
    [self enterAddress:nil];
}*/
/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    addressString = [[NSUserDefaults standardUserDefaults]
                     stringForKey:@"webaddress"];
    NSLog(@"adress string is %@:",addressString );
    address.text=addressString;
    [self enterAddress:nil];
}*/
-(void)viewDidAppear:(BOOL)animated
{ NSString *currentURL= webView.request.URL.absoluteString;
    address.text=currentURL;

    
}
- (void)viewDidLoad

{  
       
   [[NSUserDefaults standardUserDefaults]synchronize];

    [mySwitch setOn:NO animated:YES];
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
   
    [webView loadRequest:req];
    [self openDB];
    
    [self createTable:@"browsehistory" withField1:@"date" withField2:@"webPage" ];
    [super viewDidLoad];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) openDB{
    if (sqlite3_open([[self filePath] UTF8String], &historyDB)!= SQLITE_OK) {
        sqlite3_close(historyDB);
        NSAssert(0, @"Database Failed to Open");
        
    }else{
        NSLog(@"Database Opened");
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *currentURL= webView.request.URL.absoluteString;
    address.text=currentURL;


}
- (IBAction)singleTap:(UITapGestureRecognizer *)recogniser;{
    self.address.text=@"";
    NSLog(@"hehehehe");
}

-(NSString *)filePath{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    return[[paths objectAtIndex:0]stringByAppendingPathComponent:@"historyDB.sql"];
    
}



-(void)createTable:(NSString *)tableName
        withField1:(NSString *)field1
        withField2:(NSString *)field2
{
    
    
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@'TEXT  PRIMARY KEY ,'%@' TEXT ); ",tableName,field1,field2];
    if (sqlite3_exec(historyDB, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        sqlite3_close(historyDB);
        NSAssert(0, @"could not create table");
        
    }else{
        NSLog(@"table created");
        
    }
    
}





- (IBAction)enterAddress:(id)sender{
   // NSString *addressString=[[NSString alloc]init];

    addressString=address.text;
    NSString *http=[[NSString alloc]initWithFormat:@"http://"];
    NSString *stringWithHttp=[[NSString alloc]init];
    stringWithHttp=[http stringByAppendingString:addressString];
    NSLog(@"%@",addressString);
    NSURL *url = [NSURL URLWithString:stringWithHttp];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    //address.text=@"";
    [NSTimer scheduledTimerWithTimeInterval:(0.5) target:self selector:@selector(loading) userInfo:Nil repeats:YES];
    
   // NSString *webAddress= self.address.text ;
    //  NSDateFormatter *f = [[NSDateFormatter alloc] init];
    // [f setDateFormat:@"dd/MM/YYYY HH-mm"];
    //  NSDate *theDate = [f dateFromString:@"10/01/2010 13-55"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd,yyyy  HH:mm"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate:now];
    
    // NSDate *theDate=[NSDate date];
    
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO browsehistory('date','webPage')VALUES ('%@','%@')",dateString,addressString];
    char *err;
    if (sqlite3_exec(historyDB, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        
        sqlite3_close(historyDB);
        NSAssert(0, @"could not update table");
        
    }else{
        NSLog(@"table Updated");
        
    }
    //self.diastolicText.text=@"";

        


}
-(void)loading {
    if (!webView.loading) {
        [activityIndicator stopAnimating];
        activityIndicator.hidden = YES;
    }
    else { [activityIndicator startAnimating]; activityIndicator.hidden = NO; }
}



- (IBAction)exit:(id)sender {
    [address resignFirstResponder];
}

- (IBAction)history:(id)sender {
    [self performSegueWithIdentifier:@"openHistory" sender:nil];
    
}

- (IBAction)fullScreen:(id)sender {
    
 
    BOOL yn=mySwitch.isOn;
    if (yn==YES) {
        address.hidden=YES;
        historyButton.hidden=YES;
        goButton.hidden=YES;
        [self.navigationController setToolbarHidden:YES];
         activityIndicator.hidden = YES;
    } else {
        address.hidden=NO;
        historyButton.hidden=NO;
        goButton.hidden=NO;
        [self.navigationController setToolbarHidden:NO];
         activityIndicator.hidden = NO;
    }
   
    
    
    
}

- (IBAction)didEndOnExit:(id)sender {
    [sender resignFirstResponder];
    
    [self enterAddress:nil];
   /* NSString *addressString=[[NSString alloc]init];
    addressString=address.text;
    NSString *http=[[NSString alloc]initWithFormat:@"http://"];
    NSString *stringWithHttp=[[NSString alloc]init];
    stringWithHttp=[http stringByAppendingString:addressString];
    NSLog(@"%@",addressString);
    NSURL *url = [NSURL URLWithString:stringWithHttp];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    addressString=nil;
    [NSTimer scheduledTimerWithTimeInterval:(0.5) target:self selector:@selector(loading) userInfo:Nil repeats:YES];*/
    
    
    
    
}




@end