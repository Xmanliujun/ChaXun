#import "CityList.h"

#define INSERT @"INSERT INTO city_name (city) VALUES (?);"

#define SELECT_LIKE @"SELECT id, city FROM city_name WHERE city LIKE '%@%%' ORDER BY id ASC;"

@implementation CityList

- (int)insert:(CityListData *)city
{
    sqlite3* database = [[DatabaseConfiguration instance] database];
	sqlite3_stmt *statement = nil;
	BOOL result = NO;
	
	@try {
		[self beginTransaction];
		
		const char *sql = [INSERT UTF8String];
		int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
		
		if( status == SQLITE_OK ) {
            
			int i = 1;
			[self setText:statement string:city.name index:i++];
			
			if( sqlite3_step( statement ) == SQLITE_DONE ) {
				result = YES;
			}
		}
		
		if(result != YES) {
			NSString* errMsg = [NSString stringWithFormat:@"%s",sqlite3_errmsg( database )];
			NSString* errCode = [NSString stringWithFormat:@"%d",sqlite3_errcode( database )];
			@throw [NSException exceptionWithName:errMsg reason:errCode userInfo:nil];
		}
	}
	@catch (NSException* e) {
		[self rollbackTransaction];
		
		@throw e;
	}
	@finally {
		if(statement != nil) {
			sqlite3_finalize( statement );
		}
		
		if(result == YES) {
			[self commitTransaction];
		}
	}
	return result;
}

- (NSMutableArray *)getCityName:(NSString *)key
{
    sqlite3* database = [[DatabaseConfiguration instance] database];
	sqlite3_stmt *statement = nil;
	NSMutableArray* result = nil;
	NSString *strSql = [NSString stringWithFormat:SELECT_LIKE, key];
    
	const char *sql = [strSql UTF8String];
	int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
	
	if( status == SQLITE_OK ) {
        
		int i = 1;
        [self setText:statement string:key index:i++];
		
		result = [[NSMutableArray alloc] init];
		while( sqlite3_step( statement ) == SQLITE_ROW ) {
			[result addObject:[self getEntity:statement]];
		}
	}
	else {
		NSString* errMsg = [NSString stringWithFormat:@"%s",sqlite3_errmsg( database )];
		NSString* errCode = [NSString stringWithFormat:@"%d",sqlite3_errcode( database )];
		@throw [NSException exceptionWithName:errMsg reason:errCode userInfo:nil];
	}
	
	sqlite3_finalize( statement );
	
	return result;
}

- (CityListData*)getEntity:(sqlite3_stmt*)statement
{
    int i = 0;
    
    CityListData *db = [[CityListData alloc] init];
    db.record_id = [self getInteger:statement columnIndex:i++];
    db.name = [self getString:statement columnIndex:i++ nullValue:nil];
    return db;
}






@end
