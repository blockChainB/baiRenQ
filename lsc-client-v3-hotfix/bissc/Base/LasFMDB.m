//
//  LSFMDB.m
//  smart
//
//  Created by 龙广发 on 2019/6/28.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "LasFMDB.h"
@implementation LasFMDB

-(instancetype)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

-(void) createAllTable {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    // 这里执行创建数据库,以后的shareDatabase系列都属于获取当前的数据库引用
    JQFMDB *db = [JQFMDB shareDatabase:@"YGClientService.sqlite" path:path];
    
    if (![db jq_isExistTable:@"YG_home"]) {
        [db jq_createTable:@"YG_home" dicOrModel:[YGJsonModel class]];//首页
    }
    
    if (![db jq_isExistTable:@"YG_home_Site"]) {
        [db jq_createTable:@"YG_home_Site" dicOrModel:[YGJsonModel class]];//首页站点
    }

    if (![db jq_isExistTable:@"YG_service_home"]) {
        [db jq_createTable:@"YG_service_home" dicOrModel:[YGJsonModel class]];//服务首页
    }
    
    if (![db jq_isExistTable:@"YG_dynamic_list"]) {
        [db jq_createTable:@"YG_dynamic_list" dicOrModel:[YGJsonModel class]];//动态列表
    }

    if (![db jq_isExistTable:@"YG_need_list"]) {
        [db jq_createTable:@"YG_need_list" dicOrModel:[YGJsonModel class]];//合作列表
    }

    if (![db jq_isExistTable:@"YG_contact_list"]) {
        [db jq_createTable:@"YG_contact_list" dicOrModel:[YGJsonModel class]];//人脉
    }

    if (![db jq_isExistTable:@"YG_AllApp"]) {
        [db jq_createTable:@"YG_AllApp" dicOrModel:[YGJsonModel class]];//全部应用
    }

    if (![db jq_isExistTable:@"YG_UserInfo"]) {
        [db jq_createTable:@"YG_UserInfo" dicOrModel:[YGJsonModel class]];//全部应用
    }

    if (![db jq_isExistTable:@"YGEnterprise_top"]) {
        [db jq_createTable:@"YGEnterprise_top" dicOrModel:[YGJsonModel class]];//企业广场轮播
    }

    if (![db jq_isExistTable:@"YGEnterprise_List"]) {
        [db jq_createTable:@"YGEnterprise_List" dicOrModel:[YGJsonModel class]];//企业广场list
    }

    if (![db jq_isExistTable:@"YGActivity_List"]) {
        [db jq_createTable:@"YGActivity_List" dicOrModel:[YGJsonModel class]];//活动列表list
    }

    if (![db jq_isExistTable:@"YGParkCartNum"]) {
        [db jq_createTable:@"YGParkCartNum" dicOrModel:[YGJsonModel class]];//停车场车位
    }
    
    if (![db jq_isExistTable:@"YGParkCartNumList"]) {
//        [db jq_createTable:@"YGParkCartNumList" dicOrModel:[YGParkManagerModel class]];//已绑定车牌
    }

}
-(void) deletedAllTableData {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    // 这里执行创建数据库,以后的shareDatabase系列都属于获取当前的数据库引用
    JQFMDB *db = [JQFMDB shareDatabase:@"YGClientService.sqlite" path:path];

    [db jq_deleteAllDataFromTable:@"YG_home"];
    [db jq_deleteAllDataFromTable:@"YG_home_Site"];
    [db jq_deleteAllDataFromTable:@"YG_service_home"];
    [db jq_deleteAllDataFromTable:@"YG_dynamic_list"];
    [db jq_deleteAllDataFromTable:@"YG_need_list"];
    [db jq_deleteAllDataFromTable:@"YG_contact_list"];
    [db jq_deleteAllDataFromTable:@"YG_AllApp"];
    [db jq_deleteAllDataFromTable:@"YG_UserInfo"];
    [db jq_deleteAllDataFromTable:@"YGEnterprise_top"];
    [db jq_deleteAllDataFromTable:@"YGEnterprise_List"];
    [db jq_deleteAllDataFromTable:@"YGActivity_List"];
    [db jq_deleteAllDataFromTable:@"YGParkCartNum"];
    [db jq_deleteAllDataFromTable:@"YGParkCartNumList"];

}


@end
