//
//  jb_check.m
//  jailbreak_check
//
//  Created by jhaoheng on 2016/1/11.
//  Copyright © 2016年 max. All rights reserved.
//

#import "jb_check.h"

@implementation jb_check

+ (BOOL)is_jb
{
    jb_check *robotic = [[jb_check alloc] init];
    if ([robotic check_filePath] || [robotic check_URL_SCHEME] || [robotic check_Permissions] || [robotic check_stat_for_cydia] || [robotic check_isFishHook] || [robotic check_Unusual_lib] || [robotic check_env]) {
        return YES;
    }
    return NO;
}


#pragma mark - 判定越獄文件
- (BOOL)check_filePath
{
    NSArray *filePathArray = [[NSArray alloc] initWithObjects:
                              @"/Applications/Cydia.app",
                              @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                              @"/bin/bash",
                              @"/usr/sbin/sshd",
                              @"/etc/apt",
                              @"/private/var/lib/apt/",
                              nil];
    
    
    NSString *filePath;
    
    for (int i=0; i<filePathArray.count; i++) {
        
        filePath = [filePathArray objectAtIndex:i];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSLog(@"filePath get 'jailbreak'");
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - cydia 的 url scheme
- (BOOL)check_URL_SCHEME
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        NSLog(@"url scheme get 'jailbreak'");
        return YES;
    }
    return NO;
    
}

#pragma mark - 讀取路徑，判斷權限，一般無法讀取，權限不足
- (BOOL)check_Permissions
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
//        NSLog(@"Device is jailbroken");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"
                                                                               error:nil];
        if (applist.count > 0) {
            NSLog(@"Permissions get 'jailbreak'");
            return YES;
        }
//        NSLog(@"applist = %@",applist);
    }
    return NO;
}

#pragma mark - 攻擊者回避 filemanager，使用 stat 檢測 Cydia 等工具
- (BOOL)check_stat_for_cydia
{
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        NSLog(@"stat_for_cydia get 'jailbreak'");
        return YES;
    }
    return NO;
}

#pragma mark - 攻擊者透過釣魚程式，綁架了 stat
//檢查 stat 使否有被換掉
- (BOOL)check_isFishHook
{
    int ret ;
    Dl_info dylib_info;
    int (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
//        NSLog(@"lib :%s", dylib_info.dli_fname);
        NSString *name = [NSString stringWithFormat:@"%s",dylib_info.dli_fname];
        if (![name isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
            NSLog(@"isFishHook get 'jailbreak'");
            return YES;
        }
    }
    return NO;
}

#pragma mark - 檢測應用程式環境是否被連接了異常動態庫
- (BOOL)check_Unusual_lib
{
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
        NSString *name = [[NSString alloc]initWithUTF8String:_dyld_get_image_name(i)];
//        NSLog(@"--%@", name);
        if ([name isEqualToString:@"Library/MobileSubstrate/MobileSubstrate.dylib"]) {
            NSLog(@"Unusual_lib get 'jailbreak'");
            return YES;
        }
    }
    return NO;
}


#pragma mark - 檢測當前程式運行的環境變量
- (BOOL)check_env
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
//    NSLog(@"%s", env);
    if (env != NULL) {
        NSLog(@"env get 'jailbreak'");
        return YES;
    }
    return NO;
    
}


@end
