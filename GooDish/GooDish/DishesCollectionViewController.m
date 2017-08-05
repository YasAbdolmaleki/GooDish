//
//  DishesCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "DishesCollectionViewController.h"

#import "DishCollectionViewController.h"
#import "DishHeaderCollectionViewCell.h"
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
    [self setupNavigationBar];
    [self fetchDishes:nil];
}

- (void)setupNavigationBar {
    [[self.navigationController navigationBar] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];

    UIBarButtonItem *addNewReview = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add-new-review"]
                                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(addNewReview)];
    self.navigationItem.rightBarButtonItem = addNewReview;
}

- (void)addNewReview {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Singup_iPhone" bundle:nil];
    UICollectionViewController *dishesCVC = [storyboard instantiateViewControllerWithIdentifier:@"SingupViewController"];
    [self.navigationController pushViewController:dishesCVC animated:YES];
}

- (void)setupView {
    [self pullToRefresh];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DishHeaderCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([DishHeaderCollectionViewCell class])];
    
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
    
    NSError *error;
    NSURL *url = [NSURL URLWithString:@"https://firebasestorage.googleapis.com/v0/b/goodish-e4f32.appspot.com/o/dishes.json?alt=media&token=b22ed84c-5b1d-4e48-a6ba-0277c1551109"];
    NSData *dishesData = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *dishesJsonParsed = [NSJSONSerialization JSONObjectWithData:dishesData options:0 error:&error];
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
        
        DishHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DishHeaderCollectionViewCell class])
                                                                                 forIndexPath:indexPath];

        [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:self.currentDish.imageUrl]
                          placeholderImage:[UIImage imageNamed:@"dish-placeholder"]];
        cell.restaurantLabel.text = self.restaurant.name;
        cell.restaurantDistanceLabel.text = self.restaurant.distance;
        cell.dishPriceLabel.text = self.currentDish.price;
        cell.numberOfReviewsLabel.text = self.dishReview.count;
        
        //need to do some calculation to get the image self.dishReview.ratings
        [cell.starRatingImage sd_setImageWithURL:[NSURL URLWithString:@"https://i.stack.imgur.com/sGnY4.jpg"]];
        
        cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
        cell.layer.shadowRadius = 2.0f;
        cell.layer.shadowOpacity = 1.0f;
        cell.layer.masksToBounds = NO;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;

        return cell;
    }

    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchCollectionViewCell class]) forIndexPath:indexPath];
   
    cell.delegate = self;

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(375, 140);
    }
    return CGSizeMake(375, 50);
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        DishCollectionViewController *dishCollectionViewController = [[DishCollectionViewController alloc] init];
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Dish_iPhone" bundle:nil];
        
        dishCollectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"DishCollectionViewController"];
    
        dishCollectionViewController.dish = self.dishes[indexPath.row];
        
        [self.navigationController pushViewController:dishCollectionViewController animated:YES];

    }
    
    return NO;
    
}



@end
