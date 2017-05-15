//
//  UserModel.h
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "UserModel.h"

@interface UserModel : NSObject<NSCoding>
@property (assign, nonatomic) NSInteger agentType;
@property (copy, nonatomic) NSString *care;
@property (copy, nonatomic) NSString *coin;
@property (assign, nonatomic) NSInteger coinPass;
@property (copy, nonatomic) NSString *easemobPassword;
@property (copy, nonatomic) NSString *easemobUsername;
@property (copy, nonatomic) NSString *email;
@property (assign, nonatomic) NSInteger enable;
@property (assign, nonatomic) NSInteger fanDian;
@property (assign, nonatomic) float fcoin;
@property (assign, nonatomic) NSInteger flight;
@property (assign, nonatomic) NSInteger flightAmount;
@property (assign, nonatomic) NSInteger grade;
@property (assign, nonatomic) NSInteger handPass;
@property (copy, nonatomic) NSString *items;
@property (assign, nonatomic) NSInteger kf;
@property (copy, nonatomic) NSString *lastLoginIP;
@property (copy, nonatomic) NSString *lastLoginTime;
@property (copy, nonatomic) NSString *lastOperateIp;
@property (copy, nonatomic) NSString *lastOperateTime;
@property (copy, nonatomic) NSString *lastSessionID;
@property (copy, nonatomic) NSString *lastSessionTime;
@property (copy, nonatomic) NSString *limits;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *qq;
@property (assign, nonatomic) NSInteger rate;
@property (copy, nonatomic) NSString *reds;
@property (copy, nonatomic) NSString *regIP;
@property (copy, nonatomic) NSString *regTime;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) float scoreTotal;
@property (copy, nonatomic) NSString *services;
@property (copy, nonatomic) NSString *src;
@property (copy, nonatomic) NSString *tel;
@property (copy, nonatomic) NSString *thirdStatus;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger uid;
@property (copy, nonatomic) NSString *updateTime;
@property (assign, nonatomic) NSInteger userType;
@property (copy, nonatomic) NSString *username;
@end
