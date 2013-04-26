#import "Model.h"
#import "CityListData.h"

@interface CityList : Model

- (int)insert:(CityListData *)city;

- (NSMutableArray *)getCityName:(NSString *)key;

@end
