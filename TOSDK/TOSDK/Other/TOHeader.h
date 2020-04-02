//
//  TOHeader.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#ifndef TOHeader_h
#define TOHeader_h

#define TO_Width [UIScreen mainScreen].bounds.size.width
#define TO_Height [UIScreen mainScreen].bounds.size.height

#define kWindowW [UIScreen mainScreen].bounds.size.width
#define kWindowH [UIScreen mainScreen].bounds.size.height

#define kViewH(view)   view.bounds.size.height //应用程序的屏幕高度
#define kViewW(view)   view.bounds.size.width  //应用程序的屏幕宽度

#define kSizeScale (kWindowW == 414 ? 1.2 : (kWindowW == 320 ? 1 : 1))
//适配机型比例
#define kWidthScale (kWindowW / 375.0)
#define kHeightScale (kWindowH / 667.0)
//44 + 44
#define TOPVIEWHEIGHT (kWindowH >= 812 ? 88 : 64)
#define STATUSHEIGHT (kWindowH >= 812 ? 44 : 20)
//49 + 34
#define BOTTOM_TAB_HEIGHT (kWindowH >= 812 ? 83 : 49)
#define BOTTOM_TAB_HomeIndicator (kWindowH >= 812 ? 34 : 0)

#define K_iPhoneXStyle ((kWindowW == 375.f && kWindowH == 812.f ? YES : NO) || (kWindowW == 414.f && kWindowH == 896.f ? YES : NO))
#define KStatusBarAndNavigationBarHeight (K_iPhoneXStyle ? 88.f : 64.f)
#define KStatusBarHeight (K_iPhoneXStyle ? 44.f : 20.f)
#define KTabbarHeight (K_iPhoneXStyle ? 83.f : 49.f)
#define KMagrinBottom (K_iPhoneXStyle ? 34.f : 0.f)

#define kASSafeAreaTopHeight (kWindowH >= 812.0 ? 88 : 64)
#define KScaleWidth(width) ((width)*(kWindowW/375.f))
#define IsIphone678P          (kWindowW==414&&kWindowH==736)
#define IsIphone55c5sse          (kWindowW==320&&kWindowH==568)
#define SizeScale           (IsIphone6P ? 1.5 : 1)
#define IsIphone66s78          (kWindowW==375&&kWindowH==667)


#define kVersion(v) (([UIDevice currentDevice].systemVersion.doubleValue >= v)&&([UIDevice currentDevice].systemVersion.doubleValue < v+1))
/**
 * 字体相关
 */
#define kMianBoldFontName @"Comfortaa-Bold"
#define kMianRegularFontName @"Comfortaa-Regular"
#define kFontSize(value)    value*SizeScale
#define kFont(value)        [UIFont systemFontOfSize:value*SizeScale]

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define kAUTOSIZE_STR(str,Font) [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:Font],NSFontAttributeName, nil]]

//颜色：rgb，和16进制
#define kColorWihRGB(R,G,B)     [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kColorWithHEX(hex,opa)  [UIColor colorWithRed:((float)((hex & 0XFF0000)>>16))/255.0 green:((float)((hex & 0X00FF00)>>8))/255.0 blue:((float)(hex & 0X0000FF))/255.0 alpha:opa]
#define kYColorWithHEXAlpha(hex)  [UIColor colorWithRed:((float)((hex & 0XFF0000)>>16))/255.0 green:((float)((hex & 0X00FF00)>>8))/255.0 blue:((float)(hex & 0X0000FF))/255.0 alpha:1.0]

#define kMainBlueColor 0x696DF0

//通过Storyboard ID 在对应Storyboard中获取场景对象
#define kVCFromSb(storyboardId, storyboardName)     [[UIStoryboard storyboardWithName:storyboardName bundle:nil] \
instantiateViewControllerWithIdentifier:storyboardId]

//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#define _NSStringFromBbString(bb) [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:bb options:0] encoding:NSUTF8StringEncoding]

#define customLogEnable   [[NSUserDefaults standardUserDefaults] boolForKey:TO_LOG_ENABLE]

#define TOLog(format,...)  if(customLogEnable) {\
NSLog((@"%s[%d]" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);\
} else {}

#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#endif /* TOHeader_h */
