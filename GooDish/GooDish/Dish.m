//
//  Dish.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "Dish.h"

@implementation Dish

- (id)initWithDish:(NSDictionary *)dish {
    
    self = [self init];
    
    if (self) {
        self.dishId = [dish objectForKey:@"dishId"];
        self.name = [dish objectForKey:@"name"];
        self.cuisine = [dish objectForKey:@"cuisine"];
        self.imageUrl = [dish objectForKey:@"imageUrl"];
        self.price = [dish objectForKey:@"price"];
        self.restaurant = [dish objectForKey:@"restaurant"];
        self.review = [dish objectForKey:@"review"];
    }
    
    return self;
    
}

@end
