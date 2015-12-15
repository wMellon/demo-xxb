//
//  MusicNetKit.h
//  demo-xxb
//
//  Created by xxb on 15/12/14.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicNetKit : NSObject

+(void)getSongInformationWith:(NSString*)songId completionHandler:(void (^) (NSDictionary *data)) completionHandler;

+(void)getSongLrcWith:(NSString*)url completionHandler:(void (^) (NSString *lrcContent)) completionHandler;

@end
