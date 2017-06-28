//
//  DishesCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "DishesCollectionViewController.h"

#import "DishCollectionViewCell.h"
#import "SearchCollectionViewCell.h"

#import "Dish.h"
#import "DishReview.h"
#import "Restaurant.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface DishesCollectionViewController ()

@property (nonatomic, strong) NSArray* dishes;
@property (nonatomic, strong) Dish* currentDish;
@property (nonatomic, strong) Restaurant* restaurant;
@property (nonatomic, strong) DishReview* dishReview;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong) SearchCollectionViewCell *searchCollectionViewCell;

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
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([SearchCollectionViewCell class])];
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
    // TODO add the searching functionality
}

#pragma mark <SearchCollectionViewCellDelegate>

-(void)searchedText:(NSString *)searched {
    NSLog(@"----> %@",searched);
    [self fetchDishes:searched];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return [self.dishes count];
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        self.currentDish = [[Dish alloc] initWithDish:self.dishes[indexPath.row]];
        self.restaurant = [[Restaurant alloc] initWithRestaurant:self.currentDish.restaurant];
        self.dishReview = [[DishReview alloc] initWithDishReview:self.currentDish.review];
        
        DishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])
                                                                                 forIndexPath:indexPath];
        
        cell.layer.borderWidth=1.0f;
        cell.layer.borderColor=[UIColor grayColor].CGColor;
        
        [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:self.currentDish.imageUrl]
                          placeholderImage:[UIImage imageNamed:@"dish-placeholder"]];
        cell.dishNameLabel.text = self.currentDish.name;
        cell.restaurantLabel.text = self.restaurant.name;
        cell.restaurantDistanceLabel.text = self.restaurant.distance;
        cell.dishPriceLabel.text = self.currentDish.price;
        cell.numberOfReviewsLabel.text = self.dishReview.count;
        
        //need to do some calculation to get the image self.dishReview.ratings
        [cell.starRatingImage sd_setImageWithURL:[NSURL URLWithString:@"https://i.stack.imgur.com/sGnY4.jpg"]];
        
        return cell;
    }

    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchCollectionViewCell class]) forIndexPath:indexPath];
   
    cell.delegate = self;

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(375, 250);
    }
    return CGSizeMake(375, 50);
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        
    }
    return NO;
}



@end
