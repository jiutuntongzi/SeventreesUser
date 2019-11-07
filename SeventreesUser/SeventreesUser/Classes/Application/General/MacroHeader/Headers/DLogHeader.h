//
//  DLogHeader.h
//  Chain-Master
//
//  Created by FMMac on 2019/4/5.
//  Copyright © 2019 apple. All rights reserved.
//

#ifndef DLogHeader_h
#define DLogHeader_h

/**
 * 自定义NSLog宏打印
 * 引自：http://www.jianshu.com/p/c9df8a15d94e
 */
//# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"\n[函数名:%s]" "[行号:%d]" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define DLog(...)
#endif


#endif /* DLogHeader_h */
