//
//  MYRedListModel.h
//  Dlt
//
//  Created by Fang on 2018/1/16.
//  Copyright © 2018年 mr_chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYRedListModel : NSObject
@property (nonatomic, strong)NSNumber *amount;
@property (nonatomic, copy)NSString *ctimeStr;

+ (MYRedListModel *)showModel;

@end
