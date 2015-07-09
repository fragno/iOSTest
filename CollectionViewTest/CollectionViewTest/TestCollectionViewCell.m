//
//  TestCollectionViewCell.m
//  CollectionViewTest
//
//  Created by chrisfnxu on 6/24/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *testCellView;

@end

@implementation TestCollectionViewCell

- (instancetype)init
{
    if (self = [super init]) {
        NSLog(@"dasd");
    }
    
    return self;
}


- (void)prepareForReuse
{
    NSLog(@"prepareForReuse");
}


@end
