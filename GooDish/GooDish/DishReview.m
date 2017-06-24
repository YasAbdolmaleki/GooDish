//
//  DishReview.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-21.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "DishReview.h"

@implementation DishReview

- (id)initWithDishReview:(NSDictionary *)review {
    
    self = [self init];
    
    if (self) {
        self.ratings = [review objectForKey:@"ratings"];
        
        NSNumber  *countInNumber = [NSNumber numberWithInteger: [[review objectForKey:@"count"] integerValue]];
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *formatted = [formatter stringFromNumber:countInNumber];
    
        self.count = [NSString stringWithFormat:@"%@ %@", formatted, @"reviews"];
    }
    
    return self;
    
}

@end
