//
//  Dish.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dish : NSObject

@property (nonatomic, strong) NSNumber *dishId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cuisine;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSDictionary *restaurant;
@property (nonatomic, strong) NSDictionary *review;

- (id)initWithDish:(NSDictionary *)dish;

@end
