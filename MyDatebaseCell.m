//
//  MyDatebaseCell.m
//  ChaXun
//
//  Created by XmL on 13-4-26.
//  Copyright (c) 2013年 XmL. All rights reserved.
//

#import "MyDatebaseCell.h"

@implementation MyDatebaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 30)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.textColor = [UIColor blueColor];
        self.label.font = [UIFont fontWithName:@"Airal" size:20];
        self.label.text = @"城市名";
        [self.contentView addSubview:self.label];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
