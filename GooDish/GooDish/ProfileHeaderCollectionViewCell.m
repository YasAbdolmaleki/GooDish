//
//  ProfileHeaderCollectionViewCell.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-07-06.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "ProfileHeaderCollectionViewCell.h"

@implementation ProfileHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.width = size.width;
    layoutAttributes.frame = newFrame;
    
    //CGSize *size = contentView.systemLayoutSizeFittingSize(layoutAttributes.size)
    //var newFrame = layoutAttributes.frame
    //newFrame.size.width = CGFloat(ceilf(Float(size.width)))
    //layoutAttributes.frame = newFrame
    //isHeightCalculated = true;

    return layoutAttributes;
}

@end
