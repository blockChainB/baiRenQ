//
//  MMImageListView.m
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MMImageListView.h"
#import "MMImagePreviewView.h"
#pragma mark - ------------------ 小图List显示视图 ------------------

@interface MMImageListView ()

// 图片视图数组
@property (nonatomic, strong) NSMutableArray *imageViewsArray;
// 预览视图
@property (nonatomic, strong) MMImagePreviewView *previewView;

@property (nonatomic, strong) UIWindow *window;

//@property (nullable, nonatomic, readonly) UIViewController *viewController;

@end

@implementation MMImageListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 小图(九宫格)
        _imageViewsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            MMImageView *imageView = [[MMImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            [imageView setTapSmallView:^(MMImageView *imageView){
                [self singleTapSmallViewCallback:imageView];
            }];
            [_imageViewsArray addObject:imageView];
            [self addSubview:imageView];
        }
        // 预览视图
        _previewView = [[MMImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

#pragma mark - Setter
- (void)setMoment:(Moment *)moment
{
    _moment = moment;
    for (MMImageView *imageView in _imageViewsArray) {
        imageView.hidden = YES;
    }
    // 图片区
    NSInteger count = [moment.imgs count];
    if (count == 0) {
        self.size = CGSizeZero;
        return;
    }
    if (count >= 4) {
        // 更新视图数据
        _previewView.pageNum = 4;
        _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*4, _previewView.height);
    }else {
        // 更新视图数据
        _previewView.pageNum = count;
        _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
    }

    // 添加图片
    MMImageView *imageView = nil;
    
    for (NSInteger i = 0; i < count; i++)
    {
        if (i > 3) {

            break;
        }
        NSInteger rowNum = i/2;
        NSInteger colNum = i%2;
        
        
        CGFloat imageX = colNum * ((__kWidth-65)/2.0 + 5);
        CGFloat imageY = rowNum * ((__kWidth-65)/2.0 + 5);
        CGRect frame;

        if (count == 3 && i == 2) {
            frame = CGRectMake(imageX, imageY, __kWidth-60, (__kWidth-65)/2.0);
        }else{
            frame = CGRectMake(imageX, imageY, (__kWidth-65)/2.0, (__kWidth-65)/2.0);
        }

        //单张图片需计算实际显示size
        if (count == 1) {
            frame = CGRectMake(imageX, imageX, __kWidth - 60, (__kWidth-65)/2.0);
        }
        imageView = [self viewWithTag:1000+i];
        imageView.hidden = NO;
        imageView.frame = frame;
        imageView.layer.cornerRadius = 10.0;
        imageView.layer.masksToBounds = YES;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:moment.imgs[i]] placeholderImage:[UIImage imageNamed:@"动态图底图"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    
//    self.width = kTextWidth;
    self.height = imageView.bottom;
}

#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(MMImageView *)imageView
{
    
    _window = [[UIApplication sharedApplication] keyWindow];
    // 解除隐藏
    [_window addSubview:_previewView];
    [_window bringSubviewToFront:_previewView];
    // 清空
    [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加子视图
    NSInteger index = imageView.tag-1000;
    NSInteger count = [_moment.imgs count];
    CGRect convertRect;
    if (count == 1) {
        [_previewView.pageControl removeFromSuperview];
    }
    _previewView.pageControl.currentPage = index;
    
    


    for (NSInteger i = 0; i < count; i ++)
    {
        // 转换Frame
        MMImageView *pImageView = (MMImageView *)[self viewWithTag:1000+i];
        convertRect = [[pImageView superview] convertRect:pImageView.frame toView:_window];
        // 添加
        MMScrollView *scrollView = [[MMScrollView alloc] initWithFrame:CGRectMake(i*_previewView.width, 0, _previewView.width, _previewView.height)];
        scrollView.tag = 100+i;
        scrollView.maximumZoomScale = 2.0;
        scrollView.image = pImageView.image;
        scrollView.contentRect = convertRect;
        // 单击
        [scrollView setTapBigView:^(MMScrollView *scrollView){
            [self singleTapBigViewCallback:scrollView];
        }];
        // 长按
        [scrollView setLongPressBigView:^(MMScrollView *scrollView){
            [self longPresssBigViewCallback:scrollView];
        }];
        [_previewView.scrollView addSubview:scrollView];
        if (i == index) {
            [UIView animateWithDuration:0.3 animations:^{
                self->_previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                self->_previewView.pageControl.hidden = NO;
                [scrollView updateOriginRect];
            }];
        } else {
            [scrollView updateOriginRect];
        }
    }
    // 更新offset
    CGPoint offset = _previewView.scrollView.contentOffset;
    offset.x = index * k_screen_width;
    _previewView.scrollView.contentOffset = offset;
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(MMScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        self->_previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self->_previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [self->_previewView removeFromSuperview];
    }];
}

- (void)longPresssBigViewCallback:(MMScrollView *)scrollView
{
    
       int i = (int)(_previewView.scrollView.contentOffset.x/__kWidth);
    
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV sd_setImageWithURL:[NSURL URLWithString:_moment.imgs[i]]];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存相册到本地" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImageWriteToSavedPhotosAlbum(imageV.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    
         UIViewController *vc = [[UIViewController alloc] init];//实例化一个vc
    
        vc.view = self.previewView;//previewView这个是添加在window上面的view
    
        [_window addSubview:vc.view];//添加
        [vc presentViewController:alertController animated:YES completion:nil];
    

}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        
        [MBProgressHUD showSuccess:@"保存成功"];
    }else  {
        [MBProgressHUD showError:@"保存失败"];
    }
}

@end

#pragma mark - ------------------ 单个小图显示视图 ------------------
@implementation MMImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture
{
    if (self.tapSmallView) {
        self.tapSmallView(self);
    }
}

@end
