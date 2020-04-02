//
//  TOApplication.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/16.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOApplication.h"
#import "TOViewModel.h"
@interface TOApplication ()
@property(nonatomic,assign) BOOL isMoved;
@property (nonatomic, assign) CGFloat sX;
@property (nonatomic, assign) CGFloat sY;
@property (nonatomic, strong) TOViewModel *viewModel;
@end

@implementation TOApplication
- (void)sendEvent:(UIEvent *)event{
    
    if (self.sX == 0) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenRect.size;
        self.sX = screenSize.width;
        self.sY = screenSize.height;
    }
    
    if (event.type==UIEventTypeTouches) {
        UITouch *touch = [event.allTouches anyObject];
        
        if (touch.phase == UITouchPhaseBegan) {
            NSLog(@"UITouchPhaseBegan");
            self.isMoved = NO;
        }
        
        if (touch.phase == UITouchPhaseMoved) {
            NSLog(@"UITouchPhaseMoved");
            self.isMoved = YES;
        }
        
        if (touch.phase == UITouchPhaseEnded) {
            NSLog(@"UITouchPhaseEnded count=%lu isMoved=%d", (unsigned long)event.allTouches.count, self.isMoved);
            if (event.allTouches.count == 1) {
                UITouch *touch = [event.allTouches anyObject];
                if (@available(iOS 9.1, *)) {
                    CGPoint locationPointWindow = [touch preciseLocationInView:touch.window];
                    NSLog(@"TouchLocationWindow:(%.1f,%.1f), px:(%lf, %lf)",locationPointWindow.x,locationPointWindow.y, self.sX, self.sY);
                    //调用后台接口
                    
                    [self.viewModel to_getLogHisWithEventId:DO_IOS_COOR_CLICK b1:self.sX b2:self.sY b3:locationPointWindow.x b4:locationPointWindow.y];
                } else {
                    
                }
                
            }
            self.isMoved = NO;
        }
    }
    [super sendEvent:event];
}

- (TOViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TOViewModel alloc]init];
    }
    return _viewModel;
}

@end
