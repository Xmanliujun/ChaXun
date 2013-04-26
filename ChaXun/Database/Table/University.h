//
//  University.h
//  PlusTimesPang
//
//  Created by kimpeng on 13-4-10.
//
//

#import "Model.h"
#import "UniversityData.h"

@interface University : Model

- (NSMutableArray *)getSelectAll;

- (NSMutableArray *)getSelectUniversity:(NSString *)area;

- (NSMutableArray *)getUniversityName:(NSString *)area andName:(NSString *)name;

@end
