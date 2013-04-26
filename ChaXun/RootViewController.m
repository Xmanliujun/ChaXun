//
//  RootViewController.m
//  ChaXun
//
//  Created by XmL on 13-4-26.
//  Copyright (c) 2013年 XmL. All rights reserved.
//

#import "RootViewController.h"
#import "CityList.h"
#import "CityListData.h"
#import "MyDatebaseCell.h"
#import "University.h"
#import "UniversityData.h"



@interface RootViewController ()

@end

@implementation RootViewController
@synthesize ary;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"textBegin");

}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    NSLog(@"textChange");
    if (searchText.length != 0) {
        
  
      
     CityList *c = [[CityList alloc] init];
     [c openDatabase];
     NSMutableArray *a = [c getCityName:searchText];
         [ary removeAllObjects];
     for (CityListData *d in a) {
     NSLog(@"%@", d.name);
         
         [ary removeAllObjects];
         
         if ([ary count] == 0) {
              [ary addObject:d.name];
         }

     }
     [c closeDatabase];
     [c release];
    
    if ([ary count] != 0 ) {
        NSLog(@" !0 ");
        [myTable reloadData];
        
    }else{
        NSLog(@" 0 ");
       
    }
    
    }
    
    
   
}

-(void)dealloc
{
    [ary release];

    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    ary = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    UISearchBar * searBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    searBar.delegate = self;
    [self.view addSubview:searBar];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 200) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.tag = 10001;
    [self.view addSubview:myTable];
    [myTable release];
    
    
    
    NSArray * array = [NSArray arrayWithObjects:@"北京",@"天津",@"北海",@"长沙",@"济宁",@"青州",@"珠江",@"哈尔滨",@"长春",@"沈阳",@"青岛",@"济南",@"上海",@"重庆",@"珠海",@"拉萨",@"丽江", nil];
    CityList * c = [[CityList alloc] init];
    [c openDatabase];
    
    for (NSString * s in array) {
        CityListData * d = [[CityListData alloc] init];
        d.name = s;
        [c insert:d];
        [d release];
        
    }
    
    [c closeDatabase];
    [c release];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellid";
    
    MyDatebaseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[MyDatebaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        
        
    }
    if ([ary count] != 0) {
        cell.label.text = [ary objectAtIndex:indexPath.row];

    }
    else{
    
        cell.label.text = @"您要查的城市";
    }
    
    
    return cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([ary count] != 0) {
        return [ary count];
    }else{
    
        return 1;
    }

    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"cell button");
    
    NSString * str = [NSString stringWithFormat:@"%@",[ary objectAtIndex:indexPath.row]];
    NSLog(@"cell city is %@",str);
    
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
