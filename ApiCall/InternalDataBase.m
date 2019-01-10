//
//  DataBase.m
//  ApiCall
//
//  Created by subramanyam on 02/03/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import "DataBase.h"

static DataBase *sharedInstance = nil;
static sqlite3 *database = nil;
sqlite3_stmt *statement;
@implementation DataBase

+(DataBase*)getSharedInstance
{
    if (!sharedInstance)
    {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
    
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"user.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists userDetails (name text, password text, email text, phno text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

-(BOOL)saveDataname:(NSString*)name password:(NSString*)password
               email:(NSString*)email phno:(NSString*)phno
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into userDetails (name,password,email,phno) values (\"%@\",\"%@\", \"%@\",\"%@\")",name,
                                password,email,phno];
                                const char *insert_stmt = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL)== SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                return YES;
            }
            else
            {
                return NO;
            }
            
        }
        sqlite3_finalize(statement);
        
        }
    return NO;
  }


-(NSArray*)findByname : (NSString*)name password:(NSString*)password
        {
            const char *dbpath = [databasePath UTF8String];
            if (sqlite3_open(dbpath, &database) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"select name, password,email,phno from userDetails where name=\"%@\" and password=\"%@\"",name,password];
                const char *query_stmt = [querySQL UTF8String];
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                if (sqlite3_prepare_v2(database,
                                       query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        NSString *nameStr = [[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 0)];
                        [resultArray addObject:nameStr];
                        NSString *passwordStr = [[NSString alloc] initWithUTF8String:
                                                (const char *) sqlite3_column_text(statement, 1)];
                        [resultArray addObject:passwordStr];
                        NSString *mailStr = [[NSString alloc]initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 2)];
                        [resultArray addObject:mailStr];
                        
                        NSString *phnoStr = [[NSString alloc]initWithUTF8String:
                                             (const char *) sqlite3_column_text(statement, 3)];
                        [resultArray addObject:phnoStr];
                        return resultArray;
                    }
                    else
                    {
                        NSLog(@"Not found");
                        return nil;
                    }
                    
                }
                sqlite3_finalize(statement);
                
            }
            sqlite3_close(database);
            return nil;
        }
-(NSArray*)allData
{
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select * from userDetails"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray * dbResult = [[NSMutableArray alloc]init];
        NSMutableDictionary *resultDict = [[NSMutableDictionary alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *nameStr = [[NSString alloc] initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 0)];
                
                NSString *passwordStr = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 1)];
                
                NSString *mailStr = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 2)];
                
                
                NSString *phnoStr = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 3)];
                
                
                [resultDict setObject:nameStr forKey:@"name"];
                [resultDict setObject:passwordStr forKey:@"password"];
                [resultDict setObject:mailStr forKey:@"mail"];
                [resultDict setObject:phnoStr forKey:@"phno"];
                
                [dbResult addObject:[resultDict mutableCopy]]; // gives mutable result
               // [dbResult addObject:resultDict];   //gives immutable results
            }
            
            
            return dbResult;
            
        }
        sqlite3_finalize(statement);

    }
    sqlite3_close(database);
  
    return nil;
    
}

@end
