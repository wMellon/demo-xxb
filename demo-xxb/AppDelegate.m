//
//  AppDelegate.m
//  demo-xxb
//
//  Created by xxb on 15/11/15.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

//#import "ShareSDK.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//
////新浪微博SDK头文件
//#import "WeiboSDK.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
//    [ShareSDK registerApp:@"c758bd26778e"
//     
//          activePlatforms:@[
//                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeSinaWeibo)]
//                 onImport:^(SSDKPlatformType platformType)
//     {
//         switch (platformType)
//         {
//             //初始化的import参数注意要链接原生QQSDK。不连接会出不来
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//             default:
//                 break;
//         }
//     }
//          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
//     {
//         
//         switch (platformType)
//         {
//             case SSDKPlatformTypeSinaWeibo:
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"2225068821"
//                                           appSecret:@"36394b5c8124f003e6e9deaf07d81a84"
//                                         redirectUri:@"http://www.sharesdk.cn"
//                                            authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeWechat:
//                 [appInfo SSDKSetupWeChatByAppId:@"wx1c1d89893c580091"
//                                       appSecret:@"d4624c36b6795d1d99dcf0547af5443d"];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"1104986660"
//                                      appKey:@"irH3Wj3ssyx9nxW1"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
//             default:
//                 break;
//         }
//     }];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
