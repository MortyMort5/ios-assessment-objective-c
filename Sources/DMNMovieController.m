//
//  DMNMovieController.m
//  MovieSearch
//
//  Created by Sterling Mortensen on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "DMNMovieController.h"


static NSString *const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString *const apiKey = @"aaaa6caa748670a61846fa3cac93f89c";

@interface DMNMovieController ()

@property (nonatomic, strong) NSMutableArray *internalMovies;

@end

@implementation DMNMovieController

+ (DMNMovieController *)sharedInstance
{
    static DMNMovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DMNMovieController new];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalMovies = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)fetchMoviesBySearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:apiKey], [NSURLQueryItem queryItemWithName:@"query" value:searchTerm]];
    
    NSURL *url = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: there was an error with fetching data %@", error);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error: the data returned from the url is nil");
            completion(nil, error);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: There was an error with converting data to json");
            completion(nil, error);
            return;
        }
        
        NSDictionary *movieDictionary = jsonDictionary[@"results"];
        NSMutableArray *movieArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in movieDictionary) {
            DMNMovie *movie = [[DMNMovie alloc] initWithDictionary:dict];
            [movieArr addObject:movie];
        }
        
        self.internalMovies = movieArr;
        
        completion(movieArr, nil);
        
    }] resume];
}

- (NSArray *)movies
{
    return self.internalMovies;
}


@end
