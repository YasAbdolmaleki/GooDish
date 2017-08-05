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
@property (nonatomic, strong) ReviewCollectionViewCell *reviewCollectionViewCell;

@property (strong, nonatomic) IBOutlet UICollectionView *dishCollectionView;

@end

@implementation DishCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupNavigationBar];
    [self fetchReviews];
}

- (void)setupNavigationBar {
    UIBarButtonItem *addReview = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add-review"]
                                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(addReview)];
    self.navigationItem.rightBarButtonItem = addReview;
}

- (void)addReview {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Singup_iPhone" bundle:nil];
    UICollectionViewController *dishesCVC = [storyboard instantiateViewControllerWithIdentifier:@"SingupViewController"];
    [self.navigationController pushViewController:dishesCVC animated:YES];
}

- (void)setupView {

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DishCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([ReviewCollectionViewCell class])];
    
}

- (void)fetchReviews {
    NSError *error;
    NSURL *url = [NSURL URLWithString:@"https://firebasestorage.googleapis.com/v0/b/goodish-e4f32.appspot.com/o/reviews.json?alt=media&token=5340dab3-ebb3-48bf-aec2-806f2324a733"];
    NSData *reviewsData = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *reviewsJsonParsed = [NSJSONSerialization JSONObjectWithData:reviewsData options:0 error:&error];
    NSArray *reviews = [[NSArray alloc] initWithArray:[reviewsJsonParsed objectForKey:@"reviews"]];
    
    self.reviews = reviews;
}

- (ReviewCollectionViewCell *)reviewSizingCell{
    if (!_reviewCollectionViewCell) {
        _reviewCollectionViewCell = [[[UINib nibWithNibName:NSStringFromClass([ReviewCollectionViewCell class]) bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    }
    return _reviewCollectionViewCell;
}

#pragma mark <UICollectionViewLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(375, 250);
    }
    UICollectionViewCell *cellToFit = [self reviewSectionCellForIndexPath:indexPath isReusableCell:NO];
    return [cellToFit systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
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
    
    return [self reviewSectionCellForIndexPath:indexPath isReusableCell:YES];
    
}

- (UICollectionViewCell *)reviewSectionCellForIndexPath:(NSIndexPath *)indexPath isReusableCell:(BOOL)isReusable{
    
    self.review = [[Review alloc] initWithReview:self.reviews[indexPath.row]];
    self.reviewUser = [[ReviewUser alloc] initWithReviewUser:self.review.user];
    
    ReviewCollectionViewCell *cell = isReusable ? [self.dishCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ReviewCollectionViewCell class]) forIndexPath:indexPath] : self.reviewSizingCell;

    [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:self.reviewUser.profileImageUrl]
                         placeholderImage:[UIImage imageNamed:@"dish-placeholder"]];
    
    [cell.rating sd_setImageWithURL:[NSURL URLWithString:@"https://i.stack.imgur.com/sGnY4.jpg"]];
    cell.ratingDescription.text = self.review.description;
    
    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    [cell setCellWidth:375.0f];
    
    return cell;
}

@end
