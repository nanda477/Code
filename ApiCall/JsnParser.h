//
//  JsnParser.h
//  ApiCall
//
//  Created by subramanyam on 20/02/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsnParser : NSObject

+(void)getJsonResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;


+(void)postJsonResponse:(NSString *)urlStr parameter:(NSString *)myParameter success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;

@end
