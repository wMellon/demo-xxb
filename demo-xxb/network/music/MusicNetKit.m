//
//  MusicNetKit.m
//  demo-xxb
//
//  Created by xxb on 15/12/14.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "MusicNetKit.h"
#import "AFNetworking.h"

@implementation MusicNetKit

+(void)getSongInformationWith:(NSString*)songId completionHandler:(void (^) (NSDictionary *data)) completionHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
    [manager GET:@"http://music.baidu.com/data/music/links?songIds=250280" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionHandler(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

+(void)getSongLrcWith:(NSString*)url completionHandler:(void (^) (NSString *lrcContent)) completionHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-www-form-urlencoded"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSData *data = (NSData*)responseObject;
        completionHandler([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

@end
