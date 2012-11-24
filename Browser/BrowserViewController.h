//
//  BrowserViewController.h
//  Browser
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface BrowserViewController : UIViewController<UIGestureRecognizerDelegate>
{
NSString *addressString;
}
@property (strong, nonatomic) IBOutlet UIButton *historyButton;
@property (strong, nonatomic) IBOutlet UIButton *goButton;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UISwitch *mySwitch;

@property (strong, nonatomic) IBOutlet UITextField *address;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


- (IBAction)exit:(id)sender;


- (IBAction)history:(id)sender;


- (IBAction)fullScreen:(id)sender;

- (IBAction)didEndOnExit:(id)sender;



-(IBAction)enterAddress:(id)sender;


-(void) openDB;

-(void)createTable:(NSString *)tableName
            withField1:(NSString *)field1
            withField2:(NSString *)field2;
-(IBAction)singleTap:(UITapGestureRecognizer *)recogniser;

-(void)loading;
@end
NSTimer *timey;
sqlite3 *historyDB;