#import "CityListData.h"

@implementation CityListData

- (void)dealloc
{
    [_name release];
    
    [super dealloc];
}

@end
