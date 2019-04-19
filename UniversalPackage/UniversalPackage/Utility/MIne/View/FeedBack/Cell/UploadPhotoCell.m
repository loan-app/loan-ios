//
//  UploadPhotoCell.m
//  FlyingCowYok
//
//  Created by Single_Nobel on 2018/6/15.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "UploadPhotoCell.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "SelectImgCollectionViewCell.h"
static NSString * kSelectCell = @"selectCell";
@interface UploadPhotoCell ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView * baseCollectionView;
@property (nonatomic, strong) NSMutableArray * selectedPhotos;
@property (nonatomic, strong) NSMutableArray * selectedAssets;

@end

@implementation UploadPhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubViews];
    }
    return self;
}



#pragma mark - addSubviews

- (void)addAllSubViews {
    [self.contentView addSubview:self.baseCollectionView];
}

#pragma mark - 懒加载

- (UICollectionView *)baseCollectionView {
    if (!_baseCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(BntLength(60), BntAltitude(60));
        _baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, BntAltitude(100)) collectionViewLayout:layout];
        _baseCollectionView.delegate = self;
        _baseCollectionView.dataSource = self;
        _baseCollectionView.backgroundColor = kWhiteColor;
        _baseCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _baseCollectionView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
        [_baseCollectionView registerClass:[SelectImgCollectionViewCell class] forCellWithReuseIdentifier:kSelectCell];
    }
    return _baseCollectionView;
}

- (NSMutableArray *)selectedPhotos {
    if (!_selectedPhotos) {
        _selectedPhotos = [@[] mutableCopy];
    }
    return _selectedPhotos;
}
- (NSMutableArray *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = [@[] mutableCopy];
    }
    return _selectedAssets;
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(upLoadDelegateWithAry:)]) {
        [self.delegate upLoadDelegateWithAry:_selectedPhotos];
    }
    if (_selectedPhotos.count ==3) {
        return 3;
    }else{
        return _selectedPhotos.count + 1;
        
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectImgCollectionViewCell *selectCell = [collectionView dequeueReusableCellWithReuseIdentifier:kSelectCell forIndexPath:indexPath];
    if (indexPath.row == _selectedPhotos.count) {
        selectCell.imgView.image = kImageName(@"add");
        selectCell.deleteBtn.hidden = YES;
    } else {
        selectCell.imgView.image = _selectedPhotos[indexPath.row];
        selectCell.asset = _selectedAssets[indexPath.row];
        selectCell.deleteBtn.hidden = NO;
    }
    selectCell.deleteBtn.tag = indexPath.row;
    [selectCell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    return selectCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        [self pushTZImagePickerController];
    }
    // preview photos / 预览照片
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
    imagePickerVc.maxImagesCount = 3;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
        self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
        [self->_baseCollectionView reloadData];
        self->_baseCollectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * BntLength(80));
    }];
    [[kAppDelegate getCurrentUIVC] presentViewController:imagePickerVc animated:YES completion:nil];
}




- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 2. 在这里设置imagePickerVc的外观
    imagePickerVc.navigationBar.barTintColor = kf5d145Color;
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.oKButtonTitleColorNormal = kf5d145Color;
    imagePickerVc.naviTitleColor = kf5d145Color;
    imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.naviTitleColor = kblackColor;
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.circleCropRadius = 100;
    imagePickerVc.isStatusBarDefault = NO;
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
    }];
    [[kAppDelegate getCurrentUIVC] presentViewController:imagePickerVc animated:YES completion:nil];
}


#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [_baseCollectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
}

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        //NSLog(@"图片名字:%@",fileName);
    }
}

// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
    return YES;
}
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(id)asset {
    return YES;
}


#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_baseCollectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_baseCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_baseCollectionView reloadData];
        
    }];
}


@end
