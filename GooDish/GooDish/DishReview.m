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
        self.count = [review objectForKey:@"count"];
    }
    
    return self;
    
}

@end
