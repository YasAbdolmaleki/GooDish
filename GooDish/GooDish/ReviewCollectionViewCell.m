//
//  ReviewCollectionViewCell.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-28.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "ReviewCollectionViewCell.h"

@interface ReviewCollectionViewCell()
@property (strong,nonatomic) NSLayoutConstraint *cellWidthConstraint;
@end

@implementation ReviewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cellWidthConstraint = [self.contentView.widthAnchor constraintEqualToConstant:0.0f];

}

- (void)setCellWidth:(CGFloat)width {
    self.cellWidthConstraint.constant = width;
    self.cellWidthConstraint.active = YES;
}

@end
