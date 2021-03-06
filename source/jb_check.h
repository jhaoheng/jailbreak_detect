//
//  jb_check.h
//  jailbreak_check
//
//  Created by jhaoheng on 2016/1/11.
//  Copyright © 2016年 max. All rights reserved.
//

/*
 來源參考：
 http://blog.csdn.net/yiyaaixuexi/article/details/20286929
 http://stackoverflow.com/questions/413242/how-do-i-detect-that-an-ios-app-is-running-on-a-jailbroken-phone
 http://thwart-ipa-cracks.blogspot.tw/2008/11/detection.html
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/stat.h>  
#import <dlfcn.h>
#import <mach-o/dyld.h>  

@interface jb_check : NSObject


/*
 * 若返回 yes  ，則代表『有 jb』
 * 若返回 no   ，則代表『無 jb』
 */
+ (BOOL)is_jb;


@end
