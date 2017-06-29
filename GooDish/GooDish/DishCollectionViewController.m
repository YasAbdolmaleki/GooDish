//
//  DishCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-27.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "DishCollectionViewController.h"

#import "DishCollectionViewCell.h"

#import "Restaurant.h"
#import "DishReview.h"
#import "Dish.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface DishCollectionViewController ()

@property (nonatomic, strong) Restaurant* restaurant;
@property (nonatomic, strong) DishReview* dishReview;

@end

@implementation DishCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];

}

- (void)setupView {

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DishCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Dish *selectedDish = [[Dish alloc] initWithDish:self.dish];
    self.restaurant = [[Restaurant alloc] initWithRestaurant:selectedDish.restaurant];
    self.dishReview = [[DishReview alloc] initWithDishReview:selectedDish.review];
    
    DishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])
                                                                             forIndexPath:indexPath];
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor grayColor].CGColor;
    
    [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:selectedDish.imageUrl]
                      placeholderImage:[UIImage imageNamed:@"dish-placeholder"]];
    cell.dishNameLabel.text = selectedDish.name;
    cell.restaurantLabel.text = self.restaurant.name;
    cell.restaurantDistanceLabel.text = self.restaurant.distance;
    cell.dishPriceLabel.text = selectedDish.price;
    cell.numberOfReviewsLabel.text = self.dishReview.count;
    
    //need to do some calculation to get the image self.dishReview.ratings
    [cell.starRatingImage sd_setImageWithURL:[NSURL URLWithString:@"https://i.stack.imgur.com/sGnY4.jpg"]];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(375, 250);
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

@end
