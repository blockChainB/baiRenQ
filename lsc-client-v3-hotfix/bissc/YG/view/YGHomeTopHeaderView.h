//
//  YGHomeTopHeaderView.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGHomeTopHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) CGFloat placeholderWidth;

@property(nonatomic,strong) UIImageView *addressImg;
@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UIImageView *addressImg2;

@property(nonatomic,strong) UIView *rightView;
@property(nonatomic,strong) UIButton *codeBtn;
@property(nonatomic,strong) UIButton *weatherBtn;

@property (nonatomic ,strong)UISearchBar *searchBar;
@property (nonatomic ,strong)UIButton *searchBtn;


@property(nonatomic,strong) UILabel *titleLB;
@property(nonatomic,strong) UIView *bgView;


@property(nonatomic,strong) UIView *newsView;

@property(nonatomic,strong) UIImageView *newsImage;
@property(nonatomic,strong) UILabel *newsLabel;
@property(nonatomic,strong) UIButton *nextBtn;

@end
