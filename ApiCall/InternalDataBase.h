//
//  DataBase.h
//  ApiCall
//
//  Created by subramanyam on 02/03/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBase : NSObject
{
    NSString *databasePath;
}
+(DataBase*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)saveDataname:(NSString*)name password:(NSString*)password
      email:(NSString*)email phno:(NSString*)phno;
-(NSArray*)findByname : (NSString*)name password:(NSString*)password;
-(NSArray*) allData;

@end
