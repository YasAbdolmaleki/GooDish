//
//  NewReviewFormCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-08-05.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "NewReviewFormCollectionViewController.h"
#import "ReviewFieldCollectionViewCell.h"

@interface NewReviewFormCollectionViewController () <UICollectionViewDelegateFlowLayout, UIPickerViewDelegate>

@end

@implementation NewReviewFormCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewFieldCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([ReviewFieldCollectionViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UIPickerViewDelegate>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 3;//Or, return as suitable for you...normally we use array for dynamic
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"Choice-%ld",(long)row];//Or, your suitable title; like Choice-a, etc.
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //Here, like the table view you can get the each section of each row if you've multiple sections
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ReviewFieldCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ReviewFieldCollectionViewCell class])
                                                                                   forIndexPath:indexPath];

    UIImageView *envelopeView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    envelopeView.contentMode = UIViewContentModeScaleAspectFit;
    UIView *containerView=  [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    [containerView addSubview:envelopeView];
    cell.reviewTextField.leftViewMode = UITextFieldViewModeAlways;
    [cell.reviewTextField.leftView setFrame:envelopeView.frame];
    cell.reviewTextField.leftView = containerView;
    
    switch (indexPath.row) {
        case 0:
            envelopeView.image = [UIImage imageNamed:@"dish"];
            cell.reviewTextField.placeholder = @"Dish";
            break;
        case 1:
            envelopeView.image = [UIImage imageNamed:@"cuisine"];
            cell.reviewTextField.placeholder = @"Cuisine";
            break;
        case 2:
            envelopeView.image = [UIImage imageNamed:@"restaurant"];
            cell.reviewTextField.placeholder = @"Restaurant";
            break;
        case 3:
            envelopeView.image = [UIImage imageNamed:@"location"];
            cell.reviewTextField.placeholder = @"City";
            break;
        case 4:
            envelopeView.image = [UIImage imageNamed:@"star"];
            cell.reviewTextField.placeholder = @"Rating";
            break;
        default:
            break;
    }
    
    return cell;
}


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

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, 50);
}

@end
