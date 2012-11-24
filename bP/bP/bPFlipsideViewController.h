//
//  bPFlipsideViewController.h
//  bP
//
//  Created by ios on 05/11/12.
//  Copyright (c) 2012 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@class bPFlipsideViewController;

@protocol bPFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(bPFlipsideViewController *)controller;
@end

@interface bPFlipsideViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    sqlite3 *db;
    
    
}
@property(nonatomic,strong) NSString *systolic;
@property(nonatomic,strong) NSMutableArray *entries;
@property (weak, nonatomic) id <bPFlipsideViewControllerDelegate> delegate;


-(NSString *)filePath;
-(void)openDB;

- (IBAction)done:(id)sender;

@end
