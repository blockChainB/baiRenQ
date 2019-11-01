//
//  YGHomeTopHeaderView.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHomeTopHeaderView.h"

@implementation YGHomeTopHeaderView

-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = appBgRGBColor;
        [self createUI];
        [self Masonry];
    }
    return self;
}

-(void) createUI {
    
    
    [self addSubview:self.addressImg];
    [self addSubview:self.addressLabel];
    [self addSubview:self.addressImg2];
    [self addSubview:self.rightView];
    [self addSubview:self.codeBtn];
    [self addSubview:self.weatherBtn];
    [self addSubview:self.searchBar];
    [self addSubview:self.searchBtn];

    
    [self addSubview:self.bgView];
    
    [self addSubview:self.newsView];
    [self.newsView addSubview:self.newsImage];
    [self.newsView addSubview:self.newsLabel];
    [self.newsView addSubview:self.nextBtn];

    [self.bgView addSubview:self.titleLB];
}

-(void) Masonry {
    
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_offset(15*_Scaling);
        make.width.mas_offset(17*_Scaling);
        make.height.mas_offset(21*_Scaling);
        make.left.mas_offset(15*_Scaling);
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_offset(61*_Scaling*_Scaling);
        make.width.mas_offset(__kWidth - 30*_Scaling);
        make.height.mas_offset(30*_Scaling);
        make.left.mas_offset(15*_Scaling);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(61*_Scaling*_Scaling);
        make.width.mas_offset(__kWidth - 30*_Scaling);
        make.height.mas_offset(30*_Scaling);
        make.left.mas_offset(15*_Scaling);
    }];

  
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(1*_Scaling);
        make.width.mas_offset(__kWidth);
        make.height.mas_offset(51*_Scaling);
        make.left.mas_offset(0*_Scaling);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-7*_Scaling);
        make.width.mas_offset(80*_Scaling);
        make.height.mas_offset(17*_Scaling);
        make.left.mas_offset(15*_Scaling);
    }];


    [self.newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth - 30*_Scaling);
        make.height.mas_offset(25*_Scaling);
        make.bottom.mas_equalTo(self.bgView.mas_top).mas_offset(-4*_Scaling);
        make.centerX.mas_equalTo(self);
    }];

    [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(13*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.centerY.mas_equalTo(self.newsView);
        make.left.mas_offset(7*_Scaling);
    }];

    [self.newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth - 68*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.centerY.mas_equalTo(self.newsView);
        make.left.mas_equalTo(self.newsImage.mas_right).mas_offset(9*_Scaling);
    }];

    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(5*_Scaling);
        make.height.mas_offset(8*_Scaling);
        make.centerY.mas_equalTo(self.newsView);
        make.right.mas_offset(-21*_Scaling);
    }];
    
}

-(UILabel *)titleLB {
    
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.textAlignment = NSTextAlignmentLeft;
        _titleLB.font = [UIFont boldSystemFontOfSize:18*_Scaling];
    }
    return _titleLB;
}



-(UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}



-(UIView *)newsView {
   
    if (!_newsView) {
        _newsView = [[UIView alloc] init];
//        _newsView.backgroundColor = [UIColor whiteColor];
        _newsView.layer.cornerRadius = 5.0*_Scaling;
        _newsView.layer.masksToBounds = YES;
        _newsView.hidden = YES;
    }
    return _newsView;
}

-(UIImageView *)newsImage {
    
    if (!_newsImage) {
        _newsImage = [[UIImageView alloc] init];
    }
    return _newsImage;
}

-(UILabel *)newsLabel {
    
    if (!_newsLabel) {
        _newsLabel = [[UILabel alloc] init];
        _newsLabel.textColor = kRGBColor(0, 0, 0, 1.0);
        _newsLabel.textAlignment = NSTextAlignmentLeft;
        _newsLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _newsLabel;
}

-(UIButton *)nextBtn {
    
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _nextBtn;
}


-(UIImageView *)addressImg {
    
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc] init];
        _addressImg.image = [UIImage imageNamed:@"云谷客定位"];
    }
    return _addressImg;
}


-(UIImageView *)addressImg2 {
    
    if (!_addressImg2) {
        _addressImg2 = [[UIImageView alloc] init];
        _addressImg2.image = [UIImage imageNamed:@"ygk_home_角标"];
    }
    return _addressImg2;
}

-(UILabel *)addressLabel {
    
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.font = [UIFont boldSystemFontOfSize:22*_Scaling];
        _addressLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    }
    return _addressLabel;
}

-(UIButton *)weatherBtn {
    
    if (!_weatherBtn) {
        _weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weatherBtn setTitle:@"24℃" forState:(UIControlStateNormal)];
        [_weatherBtn setImage:[UIImage imageNamed:@"天气"] forState:(UIControlStateNormal)];
        [_weatherBtn setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:(UIControlStateNormal)];
        _weatherBtn.frame = CGRectMake(311*_Scaling, 18*_Scaling, 50*_Scaling, 14*_Scaling);
        _weatherBtn.titleLabel.font = [UIFont systemFontOfSize:11*_Scaling];
        _weatherBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -6*_Scaling, 0, 0);
        _weatherBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 2*_Scaling, 0, 0);
        
    }
    return _weatherBtn;
}

-(UIButton *)codeBtn {
    
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"扫码" forState:(UIControlStateNormal)];
        [_codeBtn setImage:[UIImage imageNamed:@"扫一扫"] forState:(UIControlStateNormal)];
        [_codeBtn setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:(UIControlStateNormal)];
        _codeBtn.frame = CGRectMake(253*_Scaling, 18*_Scaling, 47*_Scaling, 15*_Scaling);
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _codeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5*_Scaling, 0, 0);
        _codeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5*_Scaling, 0, 0);
    }
    return _codeBtn;
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

-(UIButton *)searchBtn {
    
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _searchBtn;
}

@end
