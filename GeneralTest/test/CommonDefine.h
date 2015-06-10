//
//  CommonDefine.h
//  test
//
//  Created by chrisfnxu on 4/27/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#ifndef test_CommonDefine_h
#define test_CommonDefine_h

#ifdef DEBUG
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"%s [Line %d] cost time: %f ms",__PRETTY_FUNCTION__, __LINE__, -[startTime timeIntervalSinceNow]*1000)
#else
#define TICK
#define TOCK
#endif


#endif
