//
//  Review.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-21.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "Review.h"

@implementation Review

@synthesize description;

- (id)initWithReview:(NSDictionary *)review {
    
    self = [self init];
    
    if (self) {
        self.id = [review objectForKey:@"id"];
        self.description = [review objectForKey:@"description"];
        self.ratings = [review objectForKey:@"ratings"];
        self.date = [review objectForKey:@"date"];
        self.user = [review objectForKey:@"user"];
    }
    
    return self;
    
}

@end
