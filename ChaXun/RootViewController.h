//
//  RootViewController.h
//  ChaXun
//
//  Created by XmL on 13-4-26.
//  Copyright (c) 2013年 XmL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

{
    UITableView * myTable;
    NSMutableArray * ary;

}
@property(nonatomic,retain)NSMutableArray * ary;

@end
