//
//  CLMSlideCountGesture.h
//  Counter
//
//  Created by Andrew Hulsizer on 7/1/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLMSlideCountGestureDelegate;

@interface CLMSlideCountGesture : NSObject

- (instancetype)initWithView:(UIView *)view;
@property (nonatomic, weak) id<CLMSlideCountGestureDelegate> delegate;
@end

@protocol CLMSlideCountGestureDelegate <NSObject>

- (void)counterDistanceUpdated:(NSInteger)distance;

@end