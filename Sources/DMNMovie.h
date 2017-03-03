//
//  DMNMovie.h
//  MovieSearch
//
//  Created by Sterling Mortensen on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNMovie : NSObject


@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) double rating;


- (instancetype)initWithTitle:(NSString *)title rating:(double)rating summary:(NSString *)summary NS_DESIGNATED_INITIALIZER;

@end

@interface DMNMovie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
