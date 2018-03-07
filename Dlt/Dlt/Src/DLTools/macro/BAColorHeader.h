
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 
 *********************************************************************************
 
 */

#ifndef BAColorHeader_h
#define BAColorHeader_h

#pragma mark - ***** 颜色设置

/*! RGB色值 */
//#define ba_RGBAColor(R, G, B, A)      [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

/*! 随机色 */
#define BARandomColor      [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
#define BA_ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BA_BGClearColor         [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.7f]

static inline UIColor *ba_RGBAColor(float r,float g,float b, float a) { return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];}

/*! 主题微信绿 */
#define BA_WeXin_greenColor      ba_RGBAColor(0, 190, 12, 1)

/*! 白色 1.0 white */
#define BA_White_Color          ba_RGBAColor(255, 255, 255, 1)

/*! 红色 1.0, 0.0, 0.0 RGB */
#define BA_Red_Color            ba_RGBAColor(255, 0, 0, 1)

/*! 黄色 1.0, 1.0, 0.0 RGB */
#define BA_Yellow_Color         ba_RGBAColor(255, 255, 0, 1)

/*! 绿色 0.0, 1.0, 0.0 RGB */
#define BA_Green_Color          ba_RGBAColor(0, 255, 0, 1)

/*! 蓝色 0.0, 0.0, 1.0 RGB */
#define BA_Blue_Color           ba_RGBAColor(0, 0, 255, 1)

/*! 无色 0.0 white, 0.0 alpha */
#define BA_Clear_Color          ba_RGBAColor(0, 0, 0, 0)

/*! 橙色 1.0, 0.5, 0.0 RGB */
#define BA_Orange_Color         ba_RGBAColor(255, 255, 0, 1)

/*! 黑色 0.0 white */
#define BA_Black_Color          ba_RGBAColor(0, 0, 0, 1)

/*! 浅灰色 0.667 white */
#define BA_LightGray_Color      ba_RGBAColor(255, 255, 255, 0.667)

/*! 灰色 0.5 white */
#define BA_Gray_Color           [UIColor grayColor]

/*! 青色 0.0, 1.0, 1.0 RGB */
#define BA_Cyan_Color           [UIColor cyanColor]

/*! 深灰色 0.333 white */
#define BA_DarkGray_Color       [UIColor darkGrayColor]

/*! 红褐色 1.0, 0.0, 1.0 RGB */
#define BA_Magenta_Color        [UIColor magentaColor]

/*! 棕色 0.6, 0.4, 0.2 RGB */
#define BA_Brown_Color          [UIColor brownColor]

/*! 红褐色 1.0, 0.0, 1.0 RGB */
#define BA_Magenta_Color        [UIColor magentaColor]

/*! 紫色 0.5, 0.0, 0.5 RGB */
#define BA_Purple_Color         [UIColor purpleColor]




#endif /* BAColorHeader_h */
