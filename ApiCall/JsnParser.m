//
//  JsnParser.m
//  ApiCall
//
//  Created by subramanyam on 20/02/17.
//  Copyright © 2017 some org. All rights reserved.
//

#import "JsnParser.h"

@implementation JsnParser

+(void)getJsonResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfig];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"f3cedb8a0772dcee48c673b56c61fe49c7b3f21f" forHTTPHeaderField:@"x-authorization"];

    
    
    NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse * response, NSError *error) {
        if (error) {
            failure (error);
            
        }
        else
        {
            NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"result is %@",resultDict);
            success (resultDict);
        }
    }];
    [dataTask resume];
}

+(void)postJsonResponse:(NSString *)urlStr parameter:(NSString *)myParameter success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session =[NSURLSession sessionWithConfiguration:defaultConfig];
    NSURL *str =[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:str];
    [request setValue:@"f3cedb8a0772dcee48c673b56c61fe49c7b3f21f" forHTTPHeaderField:@"x-authorization"];
    request.HTTPMethod=@"POST";
    NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",data);
        if (failure) {
            failure (error);
        }
        else
        {
            NSDictionary *rDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success (rDict);
            NSLog(@"%@",rDict);
            
        }
        
    }];
    [dataTask resume];
    
    
}


@end
