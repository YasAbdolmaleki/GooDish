//
//  DishesCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "DishesCollectionViewController.h"

#import "DishCollectionViewCell.h"
#import "Dish.h"
#import "DishReview.h"
#import "Restaurant.h"

@interface DishesCollectionViewController ()

@property (nonatomic, strong) NSArray* dishes;
@property (nonatomic, strong) Dish* currentDish;
@property (nonatomic, strong) Restaurant* restaurant;
@property (nonatomic, strong) DishReview* dishReview;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation DishesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
    
    [self fetchDishes:nil];
    
}

- (void)setupView {
    [self pullToRefresh];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DishCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])];
}

- (void)pullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshCollectionView) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshCollectionView {
    [self fetchDishes:nil];
    [self.refreshControl endRefreshing];
    [self.collectionView reloadData];
}

- (void)fetchDishes:(NSString *)searchedDish {
    
    NSString *dishesJsonRaw = [[NSBundle mainBundle] pathForResource:@"dishes" ofType:@"json"];
    NSData *dishesData = [NSData dataWithContentsOfFile:dishesJsonRaw];
    
    NSDictionary *dishesJsonParsed = [NSJSONSerialization JSONObjectWithData:dishesData options:kNilOptions error:nil];
    NSArray *dishes = [[NSArray alloc] initWithArray:[dishesJsonParsed objectForKey:@"dishes"]];
    
    self.dishes = dishes;
}

- (UIImage *)fetchImageURL:(NSString *)url {
    NSURL *imageURL = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dishes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    self.currentDish = [[Dish alloc] initWithDish:self.dishes[indexPath.row]];
    self.restaurant = [[Restaurant alloc] initWithRestaurant:self.currentDish.restaurant];
    self.dishReview = [[DishReview alloc] initWithDishReview:self.currentDish.review];
    
    DishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor grayColor].CGColor;
    
    cell.dishImage.image = [self fetchImageURL:self.currentDish.imageUrl];
    cell.dishNameLabel.text = self.currentDish.name;
    cell.restaurantLabel.text = self.restaurant.name;
    cell.restaurantDistanceLabel.text = self.restaurant.distance;
    cell.dishPriceLabel.text = self.currentDish.price;
    cell.starRatingImage.image = [self fetchImageURL:@"https://i.stack.imgur.com/sGnY4.jpg"]; //need to do some calculation to get the image self.dishReview.ratings
    cell.numberOfReviewsLabel.text = self.dishReview.count;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(375, 250);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/


@end
