//
//  DishHeaderCollectionViewCell.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-07-07.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishHeaderCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dishImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dishPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starRatingImage;
@property (weak, nonatomic) IBOutlet UILabel *numberOfReviewsLabel;
@end
