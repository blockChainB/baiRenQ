//
//  YGCooperationHeaderView.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/7.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGCooperationHeaderView.h"

@implementation YGCooperationHeaderView

//-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
//    
//    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        
//        self.backgroundColor = appBgRGBColor;
//
//        [self addSubview:self.searchBar];
//        
//        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.mas_offset(10*_Scaling*_Scaling);
//            make.width.mas_offset(__kWidth - 30*_Scaling);
//            make.height.mas_offset(30*_Scaling);
//            make.left.mas_offset(15*_Scaling);
//        }];
//
//        
//        
//    }
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = appBgRGBColor;
        
//        [self addSubview:self.searchBar];
//        
//        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.mas_offset(10*_Scaling*_Scaling);
//            make.width.mas_offset(__kWidth - 30*_Scaling);
//            make.height.mas_offset(30*_Scaling);
//            make.left.mas_offset(15*_Scaling);
//        }];
    }
    return self;
}

-(UISearchBar *)searchBar {
    
    if (!_searchBar) {
        
        _searchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake( 15*_Scaling, 61*_Scaling, __kWidth - 30*_Scaling, 30*_Scaling)];
        _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _searchBar.backgroundColor = [UIColor whiteColor];
        //隐藏背景
        [_searchBar setBackgroundImage:[UIImage new]];
        [_searchBar setTranslucent:YES];
        //圆角
        _searchBar.layer.cornerRadius = 30/2.0*_Scaling;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.placeholder = @"搜索公司、服务、场地";
        _searchBar.userInteractionEnabled = NO;
        
        
        _searchBar.backgroundImage = [UserInfo imageWithColor:[UIColor clearColor] size:_searchBar.bounds.size];
        [_searchBar setBackgroundColor: [UIColor whiteColor]];
        
        UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
        searchField.backgroundColor = [UIColor whiteColor];
        
        CGSize size = [self.searchBar.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*_Scaling]} context:nil].size;
        
        _placeholderWidth = size.width + 30*_Scaling;
        
        
        [self.searchBar setPositionAdjustment:UIOffsetMake((__kWidth - 30*_Scaling -self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        
        [searchField setValue:[UIFont systemFontOfSize:14]forKeyPath:@"_placeholderLabel.font"];
    }
    return _searchBar;
    
}

@end
