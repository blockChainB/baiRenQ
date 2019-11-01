//
//  MomentCell.m
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MomentCell.h"
#import "MomentCell.h"
#pragma mark - ------------------ 动态 ------------------

// 最大高度限制
CGFloat maxLimitHeight = 0;

@implementation MomentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
        self.contentView.backgroundColor = appBgRGBColor;
    }
    return self;
}

- (void)setUpUI
{
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];  
    _bgView.layer.cornerRadius = 3.0*_Scaling;
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_lineView];
    
    // 头像视图
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 14, 36, 36)];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.userInteractionEnabled = YES;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 5;
    [self.contentView addSubview:_headImageView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHead:)];
    [_headImageView addGestureRecognizer:tapGesture];
    
    
    // VIP头像视图
    _vipHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_headImageView.left +21, _headImageView.top +23, 15, 15)];
    _vipHeadImageView.contentMode = UIViewContentModeScaleAspectFill;
    _vipHeadImageView.userInteractionEnabled = YES;
    _vipHeadImageView.layer.masksToBounds = YES;
    _vipHeadImageView.layer.cornerRadius = 15/2.0;
    _vipHeadImageView.image = [UIImage imageNamed:@"ygk_小v"];
    _vipHeadImageView.hidden = YES;
    [self.contentView addSubview:_vipHeadImageView];
    
    // 名字视图
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+7, _headImageView.top + 3, __kWidth - 73 -85, 15)];
    _nameLab.font = [UIFont boldSystemFontOfSize:14];
    _nameLab.textColor = kRGBColor(183, 145, 83, 1.0 );
    _nameLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_nameLab];
    [_nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77);
        make.centerY.mas_equalTo(self->_headImageView);
    }];
    // 地址视图
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+7, _nameLab.bottom + 5, __kWidth - 73 -75, 11)];
    _addressLabel.font = [UIFont boldSystemFontOfSize:11];
    _addressLabel.textColor = kRGBColor(153, 153, 153, 1.0);
    _addressLabel.backgroundColor = [UIColor clearColor];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_addressLabel];
    
    
    _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _followBtn.layer.cornerRadius = 2.5;
    _followBtn.layer.masksToBounds = YES;
    [_followBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateSelected];
    [_followBtn setTitle:@"已关注" forState:(UIControlStateSelected)];
//    [_followBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 2 拷贝 6"] forState:UIControlStateSelected];
//     [_followBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 2 拷贝 7"] forState:UIControlStateNormal];
    [_followBtn setTitle:@" 关注" forState:(UIControlStateNormal)];
   
    [_followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    _followBtn.frame =  CGRectMake(__kWidth - 75*_Scaling, 17, 44*_Scaling, 18*_Scaling);

    _followBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_followBtn addTarget:self action:@selector(didfollowMoment:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_followBtn];
    
    
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.frame =  CGRectMake(__kWidth - 80*_Scaling, _headImageView.top, 60*_Scaling, 14*_Scaling);
    [_startBtn setTitle:@"待解决" forState:(UIControlStateNormal)];
    [_startBtn setTitleColor:goldRGBColor forState:(UIControlStateNormal)];
    _startBtn.titleLabel.font = [UIFont systemFontOfSize:14*_Scaling];
    _startBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10*_Scaling, 0, 0*_Scaling);
    _startBtn.hidden = YES;
    [self.contentView addSubview:_startBtn];

    
    // 正文视图
    _linkLabel = kMLLinkLabel();
    _linkLabel.font = kTextFont;
    _linkLabel.delegate = self;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kLinkTextColor};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:kLinkTextColor,NSBackgroundColorAttributeName:kHLBgColor};
    [self.contentView addSubview:_linkLabel];
    // 查看'全文'按钮
    _showAllBtn = [[UIButton alloc]init];
    _showAllBtn.titleLabel.font = kTextFont;
    _showAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _showAllBtn.backgroundColor = [UIColor clearColor];
    [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
    [_showAllBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
    [_showAllBtn addTarget:self action:@selector(fullTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_showAllBtn];
    // 图片区
    _imageListView = [[MMImageListView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageListView];
    // 位置视图
    _locationLab = [[UILabel alloc] init];
    _locationLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _locationLab.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_locationLab];
    // 时间视图
    _timeLab = [[UILabel alloc] init];
    _timeLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _timeLab.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_timeLab];
    
    
    
    // 照片数量
    _phoneNumberLabel = [[UILabel alloc] init];
    _phoneNumberLabel.textColor = [UIColor whiteColor];
    _phoneNumberLabel.font = [UIFont systemFontOfSize:35];
    _phoneNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneNumberLabel];

    // 删除视图
    _deleteBtn = [[UIButton alloc] init];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    _deleteBtn.backgroundColor = [UIColor clearColor];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:kRGBColor(30, 144, 255, 1.0) forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteMoment:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.hidden = YES;
    [self.contentView addSubview:_deleteBtn];
    
    
    
    //fixbug
    _addressLabel.hidden = true;
    _timeLab.hidden = true;
    
    // 私信视图
    _imBtn = [[UIButton alloc] init];
    _imBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [_imBtn setTitle:@"私信" forState:UIControlStateNormal];
    [_imBtn setImage:[UIImage imageNamed:@"ygk_邮件"] forState:(UIControlState)UIControlStateNormal];
    [_imBtn setTitleColor:kRGBColor(153, 153, 153, 1.0) forState:UIControlStateNormal];
    [_imBtn addTarget:self action:@selector(imMoment:) forControlEvents:UIControlEventTouchUpInside];
    _imBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    _imBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -12);
    [self.contentView addSubview:_imBtn];
    
    // 评论视图
    _commentBtn = [[UIButton alloc] init];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    _commentBtn.backgroundColor = [UIColor clearColor];
    [_commentBtn setImage:[UIImage imageNamed:@"ygk_信息"] forState:(UIControlState)UIControlStateNormal];
    [_commentBtn setTitleColor:kRGBColor(153, 153, 153, 1.0) forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commentMoment:) forControlEvents:UIControlEventTouchUpInside];
    _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -12);
    [self.contentView addSubview:_commentBtn];
    
    // 点赞视图
    _linkBtn = [[UIButton alloc] init];
    _linkBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    _linkBtn.backgroundColor = [UIColor clearColor];
    [_linkBtn setTitleColor:kRGBColor(153, 153, 153, 1.0) forState:UIControlStateNormal];
    [_linkBtn addTarget:self action:@selector(likesMoment:) forControlEvents:UIControlEventTouchUpInside];
    _linkBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    _linkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -12);
    [self.contentView addSubview:_linkBtn];
    
    // 评论视图
    _bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgImageView];
    _commentView = [[UIView alloc] init];
    [self.contentView addSubview:_commentView];

    // 最大高度限制
    maxLimitHeight = _linkLabel.font.lineHeight * 6;

}


#pragma mark - setter
- (void)setMoment:(Moment *)moment
{

    _moment = moment;
  
    NSLog(@"%@",moment);

//    _followBtn.layer.cornerRadius = 5;
//    _followBtn.layer.masksToBounds = YES;
//    _followBtn.layer.borderWidth = 1;
//    _followBtn.layer.borderColor = kRGBColor(0, 0, 0, 1.0).CGColor;
    
    [_commentBtn setTitle:[NSString stringWithFormat:@"%ld",[moment.comments count]] forState:UIControlStateNormal];
    [_linkBtn setTitle:[NSString stringWithFormat:@"%@",moment.likes] forState:UIControlStateNormal];
    _timeLab.text = [UserInfo timeStampString:moment.createTime type:@"MM-dd HH:mm"];
    
    if (moment.phoneModel.length > 0) {
        if (moment.address.length > 0) {
            _addressLabel.text = [NSString stringWithFormat:@"%@ 来自 %@",moment.address,moment.phoneModel];
        }else {
            _addressLabel.text = moment.phoneModel;
        }
    }else {
        if (moment.address.length > 0) {
            _addressLabel.text = moment.address;
        }
    }

    // 头像
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:moment.headportrait] placeholderImage:[UIImage imageNamed:@"touxiang "] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];

    if ([_moment.memberId isEqualToString:[UserInfo sharedUserInfo].userDic[@"id"]]) {
        _deleteBtn.hidden = NO;
    }else {
        _deleteBtn.hidden = YES;
    }
    
    if ([_moment.isVip isEqualToString:@"1"]) {
        
        _vipHeadImageView.hidden = NO;
    }else {
        _vipHeadImageView.hidden = YES;

    }
    
    if ([_moment.sourceId isEqualToString:[UserInfo sharedUserInfo].userDic[@"id"]]) {
        _followBtn.hidden = YES;
    }else {
        _followBtn.hidden = NO;
        _followBtn.selected = moment.isAttention;
        
        _followBtn.selected? [_followBtn setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]]:[_followBtn setBackgroundColor:[UIColor colorWithHexString:@"#007AFF"]];
    }

    
    if (moment.isLike == YES) {
        [_linkBtn setImage:[UIImage imageNamed:@"ygk_已点赞"] forState:(UIControlState)UIControlStateNormal];
        
    }else {
        [_linkBtn setImage:[UIImage imageNamed:@"ygk_点赞"] forState:(UIControlState)UIControlStateNormal];
    }
    

    // 昵称
//    if (moment.companyName.length > 0) {
//        _nameLab.text = [NSString stringWithFormat:@"%@ | %@",moment.name,moment.companyName];
//
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_nameLab.text];
//        [str addAttribute:NSForegroundColorAttributeName value:kRGBColor(46, 46, 46, 1.0) range:NSMakeRange((_nameLab.text.length - moment.companyName.length), moment.companyName.length)];
//        _nameLab.attributedText = str;
//    }else {
//        _nameLab.text = [NSString stringWithFormat:@"%@",moment.name];
//    }
    
     _nameLab.text = [NSString stringWithFormat:@"%@",moment.name];
    [_nameLab setTextColor:[UIColor blackColor]];
    
    if (moment.isSolve == YES) {
        
        [_startBtn setTitle:@"已解决" forState:(UIControlStateNormal)];
        [_startBtn setTitleColor:goldRGBColor forState:(UIControlStateNormal)];
        [_startBtn setImage:[UIImage imageNamed:@"五角星"] forState:(UIControlStateNormal)];

    }else {
        [_startBtn setTitle:@"未解决" forState:(UIControlStateNormal)];
        [_startBtn setTitleColor:grayRGBColor forState:(UIControlStateNormal)];
        [_startBtn addTarget:self action:@selector(startMoment:) forControlEvents:UIControlEventTouchUpInside];
        [_startBtn setImage:[UIImage imageNamed:@"灰色星星"] forState:(UIControlStateNormal)];
    }

    // 正文
    _showAllBtn.hidden = YES;
    _linkLabel.hidden = YES;
    CGFloat bottom = _headImageView.bottom + 23;
    CGFloat rowHeight = 0;
    if ([moment.content length]) {
        _linkLabel.hidden = NO;
        _linkLabel.text = moment.content;
        // 判断显示'全文'/'收起'
        CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:(__kWidth - 60)];
        CGFloat labH = attrStrSize.height;
        NSLog(@"%f",labH);
        if (labH >= 100) {
            _linkLabel.frame = CGRectMake(_headImageView.left, bottom, attrStrSize.width, 100);
            _showAllBtn.frame = CGRectMake(_nameLab.left, _linkLabel.bottom + kArrowHeight, kMoreLabWidth, kMoreLabHeight);
            _linkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        }else {
            _linkLabel.frame = CGRectMake(_headImageView.left, bottom, attrStrSize.width, labH);
            _showAllBtn.frame = CGRectMake(_nameLab.left, _linkLabel.bottom + kArrowHeight, kMoreLabWidth, kMoreLabHeight);
            
        }
        if (_showAllBtn.hidden) {
            bottom = _linkLabel.bottom + kPaddingValue;
        } else {
            bottom = _showAllBtn.bottom + kPaddingValue;
        }
    }
    // 图片
    _imageListView.moment = moment;
    
    if ([moment.imgs count] > 0) {
        _imageListView.origin = CGPointMake(_headImageView.left, bottom);
        bottom = _imageListView.bottom + kPaddingValue;
    }
    // 位置
    _locationLab.frame = CGRectMake(_headImageView.left, bottom, _nameLab.width, kTimeLabelH);
    CGFloat textW = [_timeLab.text boundingRectWithSize:CGSizeMake(200, kTimeLabelH)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_timeLab.font}
                                                context:nil].size.width;
    if ([moment.location length]) {
        _locationLab.hidden = NO;
        _locationLab.text = moment.location;
        _timeLab.frame = CGRectMake(_headImageView.left, _locationLab.bottom+kPaddingValue, textW, kTimeLabelH);
    } else {
        _locationLab.hidden = YES;
        _timeLab.frame = CGRectMake(_headImageView.left, bottom, textW, kTimeLabelH);
    }
    _deleteBtn.frame = CGRectMake(_timeLab.right + 20, _timeLab.top, 30, kTimeLabelH);
    bottom = _timeLab.bottom + kPaddingValue;

    
    
    // 处理评论/赞
    _commentView.frame = CGRectZero;
    _bgImageView.frame = CGRectZero;
    _bgImageView.image = nil;
    [_commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 处理赞
    CGFloat top = 0;
    CGFloat width = k_screen_width-kRightMargin-_headImageView.left;


    if ([self.isComment isEqualToString:@"2"]) {
        
    }else {
        // 处理评论
        NSInteger count = [moment.comments count];
        
//        if (count > 0) {
//            for (NSInteger i = 0; i < count; i ++) {
//
//                CommentLabel *label = [[CommentLabel alloc] initWithFrame:CGRectMake(12, top, width, 0)];
//                label.comment = [moment.comments objectAtIndex:i];
//                [label setDidClickText:^(Comment *comment) {
//                      NSDictionary *dic = [NSDictionary changeType:moment.comments[i]];
        
//        comment = [[Comment alloc] initWithDic:dic];
//
//                    if ([self.delegate respondsToSelector:@selector(didSelectComment:)]) {
//                        [self.delegate didSelectComment:comment];
//                    }
//                    if ([self.delegate respondsToSelector:@selector(didSelectComment:MomentCell:)]) {
//                        [self.delegate didSelectComment:comment MomentCell:self];
//                    }
//
//                }];
//
//                [label setDidClickLinkText:^(MLLink *link, NSString *linkText) {
//                    if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
//                        [self.delegate didClickLink:link linkText:linkText];
//                    }
//                }];
//
//                [_commentView addSubview:label];
//
//                // 更新
//                top += label.height;
//            }
//        }
    }
    
    //对应私信   转发
//    CGFloat itemWidth = self.width/3;
//    _imBtn.frame = CGRectMake(__kWidth - 15 - 68, _timeLab.top, 53, 12);
//    //对应评论 评论 拷贝 2
//    _commentBtn.frame = CGRectMake(_imBtn.left -24 -40, _timeLab.top, 53, 12);
//
//    //对应点赞  点赞 拷贝 2
//    _linkBtn.frame = CGRectMake(_commentBtn.left -24 -35, _timeLab.top, 53, 12);
//    //fixbug
//
    
    //fixbug
    //对应私信   转发
    CGFloat itemWidth = (__kWidth - 30*_Scaling)/3;
    CGFloat itemHeigth = 20;
    _imBtn.frame = CGRectMake(15*_Scaling, _timeLab.top, itemWidth, itemHeigth);
    [_imBtn setImage:[UIImage imageNamed:@"转发"] forState:UIControlStateNormal];
    [_imBtn setTitle:[NSString stringWithFormat:@"%@",moment.countZhuanfa? :@"0"]forState:UIControlStateNormal];
    
    UIView *lineView1=[[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [_imBtn addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(itemHeigth);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(lineView1);
        make.right.mas_equalTo(0);
    }];
     //对应评论 评论 拷贝 2
    _commentBtn.frame = CGRectMake(itemWidth+15*_Scaling, _timeLab.top, itemWidth, itemHeigth);
    [_commentBtn setImage:[UIImage imageNamed:@"评论 拷贝 2"] forState:UIControlStateNormal];
    [_commentBtn setTitle:[NSString stringWithFormat:@"%@",moment.countComment? :@"0"] forState:UIControlStateNormal];
    UIView *lineView2=[[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [_commentBtn addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(itemHeigth);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self->_commentBtn);
        make.right.mas_equalTo(0);
    }];
    
    
    //对应点赞  点赞 拷贝 2
    _linkBtn.frame = CGRectMake(itemWidth*2+15*_Scaling, _timeLab.top, itemWidth, itemHeigth);

    [_linkBtn setImage:[UIImage imageNamed:@"点赞 拷贝 3"] forState:UIControlStateNormal];
     [_linkBtn setImage:[UIImage imageNamed:@"点赞 拷贝 2"] forState:UIControlStateSelected];
    [_linkBtn setTitle:[NSString stringWithFormat:@"%@",moment.likes? :@"0"] forState:UIControlStateNormal];
    _linkBtn.selected = moment.isLike;
    
    
    if (moment.topicImages.count >= 4) {
        _phoneNumberLabel.hidden = NO;
        _phoneNumberLabel.frame = CGRectMake(__kWidth - 15 - 75, _timeLab.top - 55, 50, 35);
        _phoneNumberLabel.text = [NSString stringWithFormat:@"%ld",moment.topicImages.count];
    }else {
        _phoneNumberLabel.hidden = YES;
    }
    // 更新UI
    if (top > 0) {        
        _bgImageView.frame = CGRectMake(_headImageView.left, bottom, width, top + kArrowHeight);
        _bgImageView.image = [[UIImage imageNamed:@"comment_bg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        _commentView.frame = CGRectMake(_headImageView.left, bottom + kArrowHeight, width, top);

        rowHeight = _commentView.bottom + kBlank;
    } else {
        rowHeight = _timeLab.bottom + kBlank;
    }
    if ([self.isBgFram isEqualToString:@"0"]) {
        _bgView.frame = CGRectMake(0*_Scaling, 0, __kWidth, rowHeight);
        _lineView.frame = CGRectMake(15*_Scaling, rowHeight - 1, __kWidth - 30*_Scaling, 1);
    }else {
        _bgView.frame = CGRectMake(15*_Scaling, 0, __kWidth - 30*_Scaling, rowHeight);
    }
    
    // 这样做就是起到缓存行高的作用，省去重复计算!!!
    _moment.rowHeight = rowHeight;
    
}




#pragma mark - 点击事件
// 查看全文/收起
- (void)fullTextClicked:(UIButton *)sender
{
    _showAllBtn.titleLabel.backgroundColor = kHLBgColor;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self->_showAllBtn.titleLabel.backgroundColor = [UIColor clearColor];
        self->_moment.isFullText = !self->_moment.isFullText;
        if ([self.delegate respondsToSelector:@selector(didSelectFullText:)]) {
            [self.delegate didSelectFullText:self];
        }
    });
}

// 点击头像
- (void)clickHead:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(didClickProfile:)]) {
        [self.delegate didClickProfile:self];
    }
}

-(void) startMoment:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didstartComment:)]) {
        [self.delegate didstartComment:self];
    }
    
}
// 删除动态
- (void)deleteMoment:(UIButton *)sender
{
    _deleteBtn.titleLabel.backgroundColor = [UIColor lightGrayColor];
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _deleteBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didDeleteMoment:)]) {
            [self.delegate didDeleteMoment:self];
        }
    });
}


// 私信动态
- (void)imMoment:(UIButton *)sender
{
//    _imBtn.titleLabel.backgroundColor = [UIColor lightGrayColor];
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.imBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didImMoment:)]) {
            [self.delegate didImMoment:self];
        }
    });
}

// 评论动态
- (void)commentMoment:(UIButton *)sender
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.commentBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didAddComment:)]) {
            [self.delegate didAddComment:self];
        }
    });
}

// 点赞动态
- (void)likesMoment:(UIButton *)sender
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.linkBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didLikeMoment:)]) {
            [self.delegate didLikeMoment:self];
        }
    });
}

// 关注
- (void)didfollowMoment:(UIButton *)sender
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.linkBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didfollowMoment:)]) {
            [self.delegate didfollowMoment:self];
        }
    });
}


#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    // 点击动态正文或者赞高亮
    if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
        [self.delegate didClickLink:link linkText:linkText];
    }
}


- (void)didLabelLongPresslinkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel {
    
    NSLog(@"点击正文内容");
    // 点击动态正文或者赞高亮
    if ([self.delegate respondsToSelector:@selector(didLabelLongPresslinkText:linkLabel:)]) {
        [self.delegate didLabelLongPresslinkText:linkText linkLabel:linkLabel];
    }
}

@end

#pragma mark - ------------------ 评论 ------------------
@implementation CommentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _linkLabel = kMLLinkLabel();
        _linkLabel.delegate = self;
        [self addSubview:_linkLabel];
    }
    return self;
}

#pragma mark - Setter
- (void)setComment:(Comment *)comment
{
    _comment = comment;
    _linkLabel.attributedText = kMLLinkLabelAttributedText(comment);
    CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
    _linkLabel.frame = CGRectMake(5, 3, attrStrSize.width, attrStrSize.height);
    self.height = attrStrSize.height + 5;
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    if (self.didClickLinkText) {
        self.didClickLinkText(link,linkText);
    }
}

#pragma mark - 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = kHLBgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor clearColor];
        if (self.didClickText) {
            self.didClickText(_comment);
        }
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor clearColor];
}

@end
