//
//  CCEmojiView.h
//  Xxwolo
//
//  Created by 一横 on 14-5-15.
//  Copyright (c) 2014年 王一横. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCEmojiViewDelegate <NSObject>

- (void)selectedEmoji:(NSString *)emoji;
- (void)selectedDelete;
- (void)emojiSend;
@end

@interface CCEmojiView : UIView<UIScrollViewDelegate>{
    NSArray * emojis;
    UIScrollView * contentView;
    UIPageControl * pageControl;
}
@property (nonatomic,assign) id<CCEmojiViewDelegate>delegate;
@end
