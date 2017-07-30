//
//  ReviewCollectionViewCell.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-28.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *ratingDescription;
@property (weak, nonatomic) IBOutlet UIImageView *rating;

- (void)setCellWidth:(CGFloat)width;

@end
