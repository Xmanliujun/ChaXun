//
//  University.m
//  PlusTimesPang
//
//  Created by kimpeng on 13-4-10.
//
//

#import "University.h"

#define SELECT_ALL @"SELECT id, area, name FROM college ORDER BY id ASC;"
#define SELECT_ONE @"SELECT id, name FROM college WHERE area = ? ORDER BY id ASC;"
#define SELECT_LIKE @"SELECT id, name FROM college WHERE area = ? AND name LIKE '%%%@%%' ORDER BY id ASC;"

@implementation University

-(NSMutableArray*)getSelectAll
{
    sqlite3* database = [[DatabaseConfiguration instance] database];
	sqlite3_stmt *statement = nil;
	NSMutableArray* result = nil;
	
	const char *sql = [SELECT_ALL UTF8String];
    
	int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
	
	if( status == SQLITE_OK ) {
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

- (NSMutableArray *)getSelectUniversity:(NSString *)area
{
    sqlite3* database = [[DatabaseConfiguration instance] database];
	sqlite3_stmt *statement = nil;
	NSMutableArray* result = nil;
    
	const char *sql = [SELECT_ONE UTF8String];
	int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
	
	if( status == SQLITE_OK ) {
        
		int i = 1;
		[self setText:statement string:area index:i++];
		
		result = [[NSMutableArray alloc] init];
		while( sqlite3_step( statement ) == SQLITE_ROW ) {
			[result addObject:[self getName:statement]];
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

- (NSMutableArray *)getUniversityName:(NSString *)area andName:(NSString *)name
{
    sqlite3* database = [[DatabaseConfiguration instance] database];
	sqlite3_stmt *statement = nil;
	NSMutableArray* result = nil;
	NSString *strSql = [NSString stringWithFormat:SELECT_LIKE, name];
    
	const char *sql = [strSql UTF8String];
	int status = sqlite3_prepare_v2( database, sql, -1, &statement, NULL );
	
	if( status == SQLITE_OK ) {

		int i = 1;
		[self setText:statement string:area index:i++];
        [self setText:statement string:name index:i++];
		
		result = [[NSMutableArray alloc] init];
		while( sqlite3_step( statement ) == SQLITE_ROW ) {
			[result addObject:[self getName:statement]];
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

- (UniversityData *)getName:(sqlite3_stmt*)statement
{
    int i = 0;
    
    UniversityData *db = [[UniversityData alloc] init];
    db.record_id = [self getInteger:statement columnIndex:i++];
    db.name      = [self getString:statement columnIndex:i++ nullValue:nil];
    
    return db;
}

-(UniversityData*)getEntity:(sqlite3_stmt*)statement
{
    int i = 0;
    
    UniversityData *db = [[UniversityData alloc] init];
    db.record_id = [self getInteger:statement columnIndex:i++];
    db.area      = [self getString:statement columnIndex:i++ nullValue:nil];
    db.name      = [self getString:statement columnIndex:i++ nullValue:nil];
    
    return db;
}

@end
