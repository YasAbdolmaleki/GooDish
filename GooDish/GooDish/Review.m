//
//  Review.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-21.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "Review.h"

@implementation Review

- (id)initWithReview:(NSDictionary *)review {
    
    self = [self init];
    
    if (self) {
        self.ratings = [review objectForKey:@"ratings"];
        self.numberOfRewievs = [review objectForKey:@"numberOfRewievs"];
    }
    
    return self;
    
}

@end
