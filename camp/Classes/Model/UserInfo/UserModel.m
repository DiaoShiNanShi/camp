//
//  UserModel.m
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.agentType = [[aDecoder decodeObjectForKey:@"agentType"] integerValue];
        self.care = [aDecoder decodeObjectForKey:@"care"];
        self.coin = [aDecoder decodeObjectForKey:@"coin"];
        self.coinPass = [[aDecoder decodeObjectForKey:@"coinPass"] integerValue];
        self.easemobPassword = [aDecoder decodeObjectForKey:@"easemobPassword"];
        self.easemobUsername = [aDecoder decodeObjectForKey:@"easemobUsername"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.enable = [[aDecoder decodeObjectForKey:@"enable"] integerValue];
        self.fanDian = [[aDecoder decodeObjectForKey:@"fanDian"] integerValue];
        self.fcoin = [[aDecoder decodeObjectForKey:@"fcoin"] integerValue];
        self.flight = [[aDecoder decodeObjectForKey:@"flight"] integerValue];
        self.flightAmount = [[aDecoder decodeObjectForKey:@"flightAmount"] integerValue];
        self.grade = [[aDecoder decodeObjectForKey:@"grade"] integerValue];
        self.handPass = [[aDecoder decodeObjectForKey:@"handPass"] integerValue];
        self.items = [aDecoder decodeObjectForKey:@"items"];
        self.kf = [[aDecoder decodeObjectForKey:@"kf"] integerValue];
        self.lastLoginIP = [aDecoder decodeObjectForKey:@"lastLoginIP"];
        self.lastLoginTime = [aDecoder decodeObjectForKey:@"lastLoginTime"];
        self.lastOperateIp = [aDecoder decodeObjectForKey:@"lastOperateIp"];
        self.lastOperateTime = [aDecoder decodeObjectForKey:@"lastOperateTime"];
        self.lastSessionID = [aDecoder decodeObjectForKey:@"lastSessionID"];
        self.lastSessionTime = [aDecoder decodeObjectForKey:@"lastSessionTime"];
        self.limits = [aDecoder decodeObjectForKey:@"limits"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.qq = [aDecoder decodeObjectForKey:@"qq"];
        self.rate = [[aDecoder decodeObjectForKey:@"rate"] integerValue];
        self.reds = [aDecoder decodeObjectForKey:@"reds"];
        self.regIP = [aDecoder decodeObjectForKey:@"regIP"];
        self.regTime = [aDecoder decodeObjectForKey:@"regTime"];
        self.score = [[aDecoder decodeObjectForKey:@"score"] integerValue];
        self.scoreTotal = [[aDecoder decodeObjectForKey:@"scoreTotal"] integerValue];
        self.src = [aDecoder decodeObjectForKey:@"src"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
        self.thirdStatus = [aDecoder decodeObjectForKey:@"thirdStatus"];
        self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
        self.uid = [[aDecoder decodeObjectForKey:@"uid"] integerValue];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
        self.userType = [[aDecoder decodeObjectForKey:@"userType"] integerValue];
        self.username = [aDecoder decodeObjectForKey:@"username"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(_agentType) forKey:@"agentType"];
    [aCoder encodeObject:_care forKey:@"care"];
    [aCoder encodeObject:_coin forKey:@"coin"];
    [aCoder encodeObject:@(_coinPass) forKey:@"coinPass"];
    [aCoder encodeObject:_easemobPassword forKey:@"easemobPassword"];
    [aCoder encodeObject:_easemobUsername forKey:@"easemobUsername"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:@(_enable) forKey:@"enable"];
    [aCoder encodeObject:@(_fanDian) forKey:@"fanDian"];
    [aCoder encodeObject:@(_fcoin) forKey:@"fcoin"];
    [aCoder encodeObject:@(_flight) forKey:@"flight"];
    [aCoder encodeObject:@(_flightAmount) forKey:@"flightAmount"];
    [aCoder encodeObject:@(_grade) forKey:@"grade"];
    [aCoder encodeObject:@(_handPass) forKey:@"handPass"];
    [aCoder encodeObject:_items forKey:@"items"];
    [aCoder encodeObject:@(_kf) forKey:@"kf"];
    [aCoder encodeObject:_lastLoginIP forKey:@"lastLoginIP"];
    [aCoder encodeObject:_lastLoginTime forKey:@"lastLoginTime"];
    [aCoder encodeObject:_lastOperateIp forKey:@"lastOperateIp"];
    [aCoder encodeObject:_lastOperateTime forKey:@"lastOperateTime"];
    [aCoder encodeObject:_lastSessionID forKey:@"lastSessionID"];
    [aCoder encodeObject:_lastSessionTime forKey:@"lastSessionTime"];
    [aCoder encodeObject:_limits forKey:@"limits"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_qq forKey:@"qq"];
    [aCoder encodeObject:@(_rate) forKey:@"rate"];
    [aCoder encodeObject:_reds forKey:@"reds"];
    [aCoder encodeObject:_regIP forKey:@"regIP"];
    [aCoder encodeObject:_regTime forKey:@"regTime"];
    [aCoder encodeObject:@(_score) forKey:@"score"];
    [aCoder encodeObject:@(_scoreTotal) forKey:@"scoreTotal"];
    [aCoder encodeObject:_services forKey:@"services"];
    [aCoder encodeObject:_src forKey:@"src"];
    [aCoder encodeObject:_tel forKey:@"tel"];
    [aCoder encodeObject:_thirdStatus forKey:@"thirdStatus"];
    [aCoder encodeObject:@(_type) forKey:@"type"];
    [aCoder encodeObject:@(_uid) forKey:@"uid"];
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    [aCoder encodeObject:@(_userType) forKey:@"userType"];
    [aCoder encodeObject:_username forKey:@"username"];
}
@end
