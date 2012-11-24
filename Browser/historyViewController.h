//
//  historyViewController.h
//  Browser
//
//  Created by ios on 15/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowserViewController.h"
#import "sqlite3.h"
@interface historyViewController : UIViewController
{
    NSString *addressString;
    sqlite3 *historyDB;
}


- (IBAction)backTOBrowser:(id)sender;
@property(nonatomic,strong)NSMutableArray *entries;
@end
