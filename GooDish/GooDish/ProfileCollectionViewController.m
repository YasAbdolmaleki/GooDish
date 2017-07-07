//
//  ProfileCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-07-06.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "ProfileCollectionViewController.h"

#import "ProfileHeaderCollectionViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ProfileCollectionViewController ()

@end

@implementation ProfileCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ProfileHeaderCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([ProfileHeaderCollectionViewCell class])];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProfileHeaderCollectionViewCell class]) forIndexPath:indexPath];
    
    
    [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:@"https://i.ytimg.com/vi/TZiQK81Rjfw/maxresdefault.jpg"]];
    cell.nameLabel.text = @"Bob Smith";
    cell.locationLabel.text = @"Toronto, Ontario";
    cell.reviewsLabel.text = @"Reviews (231)";
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.contentSize.width, 350);
}

#pragma mark <UICollectionViewLayoutDelegate>
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
//    flowLayout.estimatedItemSize = CGSizeMake(375, 350);
//    
//    return flowLayout.estimatedItemSize;
//}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
