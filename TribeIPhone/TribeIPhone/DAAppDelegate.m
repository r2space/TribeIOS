//
//  DAAppDelegate.m
//  TribeIPhone
//
//  Created by kita on 13-4-15.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAAppDelegate.h"
#import <TribeSDK/TribeSDKHeader.h>

#define kInfoPlistKeyServerAddress @"ServerAddress"
#define kInfoPlistKeyServerPort @"ServerPort"

@implementation DAAppDelegate

// 起動プロセスがほとんど完了し、アプリの実行準備がほとんどできていることをデリゲートに通知します。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 设定缺省的服务器地址
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kServerAddress] == nil) {
        NSString *serverAddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerAddress];
        NSNumber *serverPort = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerPort];
        [[NSUserDefaults standardUserDefaults] setObject:serverAddress forKey:kServerAddress];
        [[NSUserDefaults standardUserDefaults] setInteger:serverPort.integerValue forKey:kServerPort];
    }
    
    return YES;
}

// アプリケーションが非アクティブになることを、デリゲートに伝えます。
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// アプリケーションがバックグラウンドになっていることをデリゲートに伝えます。
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// アプリケーションがフォアグラウンドに入ろうとしていることを、デリゲートに伝えます。
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    NSString *loginuid = [DALoginModule getLoginUserId];
    if (loginuid != nil) {
        [[DAUserFetcher alloc] getUserById:self uid:loginuid];
    }
}

// アプリケーションがアクティブになったことをデリゲートに伝えます。
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// アプリケーションが終了する時に、デリゲートに伝えます。
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 从新打开设备时，获取当前登陆用户的最新信息，该信息保存在文件当中，当做全局变量使用
// TODO:更新用户信息时，也需要更新该文件
- (void)didFinishFetchingUser:(DAUser *)user
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    
    NSData *userdata = [NSKeyedArchiver archivedDataWithRootObject:user];
    [userdata writeToFile:[NSString stringWithFormat:@"%@/%@", documentDir, user._id] atomically:YES];
    
    NSLog(@"save login user info ok!");
}

@end
