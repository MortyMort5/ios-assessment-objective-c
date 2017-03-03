//
//  DMNMovie.m
//  MovieSearch
//
//  Created by Sterling Mortensen on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "DMNMovie.h"

@implementation DMNMovie

-(instancetype)init
{
    return [self initWithTitle:@"" rating:0.0 summary:@""];
}

- (instancetype)initWithTitle:(NSString *)title rating:(double)rating summary:(NSString *)summary
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _rating = rating;
        _summary = [summary copy];
    }
    return self;
}
@end

@implementation DMNMovie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    double rating = [dictionary[@"vote_average"] doubleValue];
    NSString *summary = dictionary[@"overview"];
    
    if (![title isKindOfClass:[NSString class]] || ![summary isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [self initWithTitle:title rating:rating summary:summary];
    
}

@end
