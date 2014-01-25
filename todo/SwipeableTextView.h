//
//  SwipeableTextView.h
//  todo
//
//  Created by Utkarsh Sengar on 1/24/14.
//  Copyright (c) 2014 area42. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMinimumGestureLength   25
#define kMaximumVariance        5

@interface SwipeableTextView : UITextView {
    CGPoint gestureStartPoint;
}

@end