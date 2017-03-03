//
//  DMNMovieController.h
//  MovieSearch
//
//  Created by Sterling Mortensen on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMNMovie.h"

NS_ASSUME_NONNULL_BEGIN
@interface DMNMovieController : NSObject

- (instancetype)init;

+ (DMNMovieController *)sharedInstance;

- (void)fetchMoviesBySearchTerm:(NSString *)searchTerm completion:(void (^_Nullable)(NSArray *_Nullable, NSError *_Nullable))completion;

@property (nonatomic, strong) NSArray *movies;

@end
NS_ASSUME_NONNULL_END
