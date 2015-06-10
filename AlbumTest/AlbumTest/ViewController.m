//
//  ViewController.m
//  AlbumTest
//
//  Created by chrisfnxu on 4/24/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "CloudDiskFileHandle.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *uilabel;
@property (strong, nonatomic) IBOutlet UIButton *uibutton;

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.library = [[ALAssetsLibrary alloc] init];
    
    [self.uibutton setTitle:@"开始测试" forState:UIControlStateNormal];
    [self.uibutton setTitle:@"正在测试" forState:UIControlStateDisabled];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
//    self.uibutton.enabled = NO;
    [self testRepresentationMetaData];
}

#pragma mark -
#pragma mark - test functions

- (void)testRepresentationMetaData
{
    
    __block int count = 0;
    
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum|ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos) {
                [group enumerateAssetsWithOptions:NSEnumerationConcurrent usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (index != NSNotFound) {
                        @autoreleasepool {
                            ALAssetRepresentation *representation = result.defaultRepresentation;
                            NSDictionary *metadata = [representation metadata];
                            NSDictionary *exifData = [metadata objectForKey:@"{Exif}"];
                            NSString *str = [exifData objectForKey:@"LensModel"];
                            count ++;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.uilabel setText:str];
                            });
                            
                            NSLog(@"%d:%@", count, [metadata objectForKey:@"Depth"]);
                        }
                    }else{
                        self.uibutton.enabled = YES;
                        NSLog(@"done");
                        NSLog(@"done");
                    }
                }];
            }
        });
    } failureBlock:^(NSError *error) {
        NSLog(@"enumerateGroupsWithTypes failure");
    }];
    
}

- (void)testMD5Speed
{
    __block long count = 0;
    NSDate *startDate = [NSDate date];
    
    
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum|ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos) {
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (index == NSNotFound) {
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    NSLog(@"totalAssets: %ld, cost time : %f", count, [[NSDate date] timeIntervalSinceDate:startDate]);
                    return;
                }
                
                NSString *sha = @"";
                NSString *md5 = @"";
                CloudDiskFileHandle * fileHandle = [CloudDiskFileHandle fileHandleForReadingAtURL:[result defaultRepresentation].url];
                [fileHandle calculateMD5:&md5 andSHA:&sha];
                NSLog(@"asset: %@, md5: %@; sha: %@; count: %ld", [result defaultRepresentation].url, md5, sha, count);
                count = count + 1;
            }];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"enumerateGroupsWithTypes failure");
    }];
}

@end
