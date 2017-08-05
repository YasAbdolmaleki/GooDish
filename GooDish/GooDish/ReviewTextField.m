//
//  ReviewTextField.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-08-05.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "ReviewTextField.h"

@implementation ReviewTextField

- (UIEdgeInsets)getInsetsForReviewTextField {
    return UIEdgeInsetsMake(0, 50, 0, 10);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, [self getInsetsForReviewTextField]);
    
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, [self getInsetsForReviewTextField]);
    
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, [self getInsetsForReviewTextField]);
    
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeWhileEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)adjustRectWithWidthRightView:(CGRect)bounds {
    CGRect paddedRect = bounds;
    paddedRect.size.width -= CGRectGetWidth(self.rightView.frame);
    
    return paddedRect;
}

@end
