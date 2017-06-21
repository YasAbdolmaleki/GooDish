//
//  Restaurant.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-21.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (id)initWithRestaurant:(NSDictionary *)restaurant {
    
    self = [self init];
    
    if (self) {
        self.restaurantId = [restaurant objectForKey:@"restaurantId"];
        self.restaurantName = [restaurant objectForKey:@"restaurantName"];
        self.restaurantDistance = [restaurant objectForKey:@"restaurantDistance"];;
    }
    
    return self;
    
}

@end
