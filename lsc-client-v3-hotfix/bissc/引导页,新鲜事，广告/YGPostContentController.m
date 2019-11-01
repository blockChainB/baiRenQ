//
//  YGPostContentController.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/16.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGPostContentController.h"
#import <Photos/Photos.h>
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "YGDyPostCell.h"
#import "YGMapAddressController.h"
@interface YGPostContentController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,CTAssetsPickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UIButton *postBtn;
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIButton *addBtn;
@property(nonatomic,strong)UILabel *placeholderLabel;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *imageArray;
@property(nonatomic,copy) NSString *addressStr;
@property(nonatomic,strong) UITextField *addressTF;

@end

@implementation YGPostContentController

-(UILabel *)placeholderLabel {
    
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(22*_Scaling, 24*_Scaling, __kWidth -44*_Scaling, 12*_Scaling)];
        _placeholderLabel.font = [UIFont systemFontOfSize:15*_Scaling];
        _placeholderLabel.textColor = kRGBColor(153, 153, 153, 1.0);
        _placeholderLabel.text = @"发表你的想法.....";
    }
    return _placeholderLabel;
}

-(UIButton *)addBtn {
    
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"ygk_添加"] forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

-(UITextView *)textView {
    
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(19*_Scaling, 17*_Scaling, __kWidth - 38*_Scaling, 80*_Scaling)];
        _textView.font = [UIFont systemFontOfSize:15*_Scaling];
        _textView.delegate = self;
    }
    return _textView;
}



-(UIButton *)postBtn {
    
    if (!_postBtn) {
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postBtn setTitle:@"发布" forState:(UIControlStateNormal)];
        _postBtn.titleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        [_postBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _postBtn.layer.cornerRadius = 2.5*_Scaling;
        _postBtn.layer.masksToBounds = YES;
        [_postBtn setBackgroundColor:kRGBColor(226, 226, 226, 1.0)];
        [_postBtn addTarget:self action:@selector(postAction) forControlEvents:(UIControlEventTouchUpInside)];
        //        _postBtn.size = CGSizeMake(43*_Scaling, 20*_Scaling);
//        [_postBtn setBackgroundColor:goldRGBColor];
        _postBtn.userInteractionEnabled = NO;

        _postBtn.frame = CGRectMake(0, 0, 43*_Scaling, 20*_Scaling);
    }
    return _postBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.type;
    _imageArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CreateAddress:) name:@"CreateAddress" object:nil];

    self.addressStr = [UserInfo sharedUserInfo].AOIName;
    //获取共享的UserDefaults
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YGShareExtension"];
    if ([userDefaults boolForKey:@"has-new-share"])
    {
        
        NSArray *datas = [userDefaults arrayForKey:@"sharedImages"];
        
        for (NSData *data in datas) {
            UIImage *image = [UIImage imageWithData:data];
            [_imageArray addObject:image];
        }
        
        
        if ([[userDefaults objectForKey:@"sharedURL"] length] > 0) {
            
            self.textView.text = [userDefaults objectForKey:@"sharedTitle"];
            self.placeholderLabel.text = @"";

        }else {
            if (self.textView.text.length > 0) {
                self.placeholderLabel.text = @"";
            }
        }
        
        //重置分享标识
        [userDefaults setBool:NO forKey:@"has-new-share"];
        [userDefaults setObject:@"" forKey:@"sharedURL"];
        [userDefaults setValue:@[] forKey:@"sharedImages"];
        [userDefaults setObject:@"" forKey:@"sharedTitle"];
    }
    
    
    
    self.view.backgroundColor = appBgRGBColor;
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.postBtn];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];

 
    [self createTableView];
}

-(UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"ygk_back"] forState:(UIControlStateNormal)];
        _backBtn.frame = CGRectMake(10*_Scaling, 40*_Scaling, 20*_Scaling, 25*_Scaling);
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _backBtn;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void) viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

-(void) backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight - LGF_StatusAndNavBar_Height) style:(UITableViewStylePlain)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = appBgRGBColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
       
        if (_imageArray.count > 2 && _imageArray.count <6) {
            return 380*_Scaling;
        }else if (_imageArray.count > 5){
            return 514*_Scaling;
        }else {
            return 257*_Scaling;
        }
        
    }else {
        return 35*_Scaling;
    }
 
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *cellID = @"cellID1";
        
        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:self.textView];
        [cell.contentView addSubview:self.placeholderLabel];
        
        [cell.contentView addSubview:self.addBtn];
        CGFloat width = (__kWidth - 58*_Scaling)/3.0;
        
        if (_imageArray.count == 0) {
            
            self.addBtn.frame = CGRectMake(19*_Scaling , 142*_Scaling, width, width);
            
        }else  {
            
            for (int i = 0; i < self.imageArray.count; i ++) {
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(19*_Scaling + i%3 * (width + 10*_Scaling), 142*_Scaling + i/3*(width + 10*_Scaling), width, width)];
                imageView.image = self.imageArray[i];
                [cell.contentView addSubview:imageView];
            }
            if (self.imageArray.count < 9) {
                self.addBtn.frame = CGRectMake( 19*_Scaling + self.imageArray.count%3*(width + 10*_Scaling) , 142*_Scaling + self.imageArray.count/3*(width + 10*_Scaling), width, width);
            }else {
                self.addBtn.userInteractionEnabled = NO;
            }
        }
        
        if (self.textView.text.length > 0 ) {
            
            [self.postBtn setBackgroundColor:goldRGBColor];
        }
        return cell;
        
    }else {
        
        static NSString *cellID = @"cellID2";
        
        YGDyPostCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[YGDyPostCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        if (self.addressStr.length > 0) {
            cell.bgView.hidden = NO;
            cell.contentTF.text = self.addressStr;
            self.addressTF = cell.contentTF;
            cell.contentTF.delegate = self;
        }
        [cell.editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:(UIControlEventTouchUpInside)];

        return cell;

    }
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = appBgRGBColor;
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 4;
}



#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",textView.text);
    
    if (textView.text.length > 0) {
        self.placeholderLabel.text = @"";
        [self.postBtn setBackgroundColor:goldRGBColor];
        self.postBtn.userInteractionEnabled = YES;

    }else{
        self.placeholderLabel.text = @"发表你的想法.....";
        [self.postBtn setBackgroundColor:kRGBColor(226, 226, 226, 1.0)];
        self.postBtn.userInteractionEnabled = NO;

    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void) addAction {
    //    [self.imageArray addObject:@""];
    //    [_tableView reloadData];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIImagePickerController *pickerController = [UIImagePickerController new];
    //    设置代理
    pickerController.delegate = self;
    //设置允许编辑
    pickerController.allowsEditing = YES;
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            [MBProgressHUD showError:@"请去设置中开启相机权限！"];
        }else {
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerController animated:YES completion:nil];
            
        }
        
    }];
    UIAlertAction *seletedAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            if (status != PHAuthorizationStatusAuthorized) return;
            dispatch_async(dispatch_get_main_queue(), ^{
                CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                picker.delegate = self;
                // 显示选择的索引
                picker.showsSelectionIndex = YES;
                // 设置相册的类型：相机胶卷 + 自定义相册
                picker.assetCollectionSubtypes = @[
                                                   @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                                   @(PHAssetCollectionSubtypeAlbumRegular)];
                // 不需要显示空的相册
                picker.showsEmptyAlbums = NO;
                [self presentViewController:picker animated:YES completion:nil];
            });
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cameraAction];
    [alertController addAction:seletedAction];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark -- imagePickerViewController的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取图片 设置图片
    //    [[UserInfo sharedUserInfo]loadInfoFromSandbox];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.imageArray addObject:image];
    
    //图片存入相册
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    //隐藏当前窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    
}


#pragma mark - <CTAssetsPickerControllerDelegate>
-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 9 - self.imageArray.count;
    if (picker.selectedAssets.count >= max) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%zd张图片", max] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [picker presentViewController:alert animated:YES completion:nil];
        // 这里不能使用self来modal别的控制器，因为此时self.view不在window上
        return NO;
    }
    return YES;
}

-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 基本配置
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode   = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    options.networkAccessAllowed = YES;
    // 遍历选择的所有图片
    
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
//        CGSize size = CGSizeMake(asset.pixelWidth , asset.pixelHeight );

        // 获取图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            NSLog(@"%@",info);
            NSLog(@"%@",result);
            [self.imageArray addObject:result];
            [self.tableView reloadData];

        }];
    }

}

-(void) postAction {
    
    [MBProgressHUD showGifToView:self.view];
    
    [self.addressTF resignFirstResponder];
    
    if (self.imageArray.count > 0) {
        
        [YGHttpRequest uploadfiles:@"file" images:self.imageArray type:@"likspace-app-topic" callback:^(id obj) {
            NSLog(@"%@",obj);
            NSMutableArray *idArr = [NSMutableArray array];
            for (NSDictionary *dd in obj[@"data"]) {
                [idArr addObject:dd[@"id"]];
            }
            [self postImageArray:[idArr componentsJoinedByString:@","]];
        }];

    }else {
        [self postImageArray:@""];
    }
}

-(void) postImageArray:(NSString *)str {
    
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    
    if (self.textView.text.length == 0) {
        self.textView.text = @"";
    }
    NSString *publishType;
    
    if ([self.type isEqualToString:@"新鲜事"]) {
        publishType = @"dynamic";
    }else {
        publishType = @"need";
    }
    NSString *addressS;
    if (self.addressTF.text.length > 0) {
        addressS = self.addressTF.text;
    }else {
        addressS = @"";
    }
    
    NSDictionary *dic = @{@"releaseType":@"member",@"content":self.textView.text,@"imgs":str,@"address":addressS,@"sourceId":[UserInfo sharedUserInfo].userDic[@"id"],@"publishType":publishType};

    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/publishDynamic"] Parameters:dic callback:^(id obj) {
        [MBProgressHUD hideGifHUDForView:self.view];
        BOOL istrue   = [obj[@"success"] boolValue];
        if (istrue) {
            [MBProgressHUD showSuccess:obj[@"msg"]];
            if ([self.type isEqualToString:@"新鲜事"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
            }else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh2" object:nil];
            }
            UIViewController *vc = self.navigationController.viewControllers[0];
            [self.navigationController popToViewController:vc animated:YES];
            
        }else {
            [MBProgressHUD showError:obj[@"msg"]];
        }
        
    }];
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([UIDevice currentDevice].systemVersion.floatValue < 11)
    {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")])
    {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             // iOS 11之后，图片编辑界面最上层会出现一个宽度<42的view，会遮盖住左下方的cancel按钮，使cancel按钮很难被点击到，故改变该view的层级结构
             if (obj.frame.size.width < 42)
             {
                 [viewController.view sendSubviewToBack:obj];
                 *stop = YES;
             }
         }];
    }
}


-(void) editBtnAction {
    
    NSLog(@"编辑");
    YGMapAddressController *controller = [[YGMapAddressController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.block = ^(NSString *address) {
        self.addressStr = address;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) CreateAddress:(NSNotification *)noti {
    
    self.addressStr = noti.object;
    [self.tableView reloadData];
}
@end
