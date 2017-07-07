//
//  DishCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-27.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "DishCollectionViewController.h"

#import "DishCollectionViewCell.h"
#import "ReviewCollectionViewCell.h"

#import "ProfileCollectionViewController.h"

#import "Restaurant.h"
#import "DishReview.h"
#import "Dish.h"
#import "Review.h"
#import "ReviewUser.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface DishCollectionViewController ()

@property (nonatomic, strong) Restaurant* restaurant;
@property (nonatomic, strong) DishReview* dishReview;
@property (nonatomic, strong) NSArray* reviews;
@property (nonatomic, strong) Review* review;
@property (nonatomic, strong) ReviewUser* reviewUser;

@end

@implementation DishCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self fetchReviews];
}

- (void)setupView {

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DishCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([ReviewCollectionViewCell class])];
    
}

- (void)fetchReviews {
    
    NSString *reviewsJsonRaw = [[NSBundle mainBundle] pathForResource:@"reviews" ofType:@"json"];
    NSData *reviewsData = [NSData dataWithContentsOfFile:reviewsJsonRaw];
    
    NSDictionary *reviewsJsonParsed = [NSJSONSerialization JSONObjectWithData:reviewsData options:kNilOptions error:nil];
    NSArray *reviews = [[NSArray alloc] initWithArray:[reviewsJsonParsed objectForKey:@"reviews"]];
    
    self.reviews = reviews;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.reviews count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        Dish *selectedDish = [[Dish alloc] initWithDish:self.dish];
        self.restaurant = [[Restaurant alloc] initWithRestaurant:selectedDish.restaurant];
        self.dishReview = [[DishReview alloc] initWithDishReview:selectedDish.review];
        
        DishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])
                                                                                 forIndexPath:indexPath];
        
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

    self.review = [[Review alloc] initWithReview:self.reviews[indexPath.row]];
    self.reviewUser = [[ReviewUser alloc] initWithReviewUser:self.review.user];

    
    ReviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ReviewCollectionViewCell class])
                                                                             forIndexPath:indexPath];
    
    [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:self.reviewUser.profileImageUrl]
                      placeholderImage:[UIImage imageNamed:@"dish-placeholder"]];
    
    [cell.rating sd_setImageWithURL:[NSURL URLWithString:@"https://i.stack.imgur.com/sGnY4.jpg"]];
    cell.ratingDescription.text = self.review.description;
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor grayColor].CGColor;

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(375, 250);
    }
    return CGSizeMake(375, 120);
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        ProfileCollectionViewController *profileCollectionViewController = [[ProfileCollectionViewController alloc] init];
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Profile_iPhone" bundle:nil];
        
        profileCollectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"ProfileCollectionViewController"];
        
        [self.navigationController pushViewController:profileCollectionViewController animated:YES];
        
    }
    
    return NO;
    
}

@end
