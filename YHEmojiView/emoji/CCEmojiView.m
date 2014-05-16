//
//  CCEmojiView.m
//  Xxwolo
//
//  Created by 一横 on 14-5-15.
//  Copyright (c) 2014年 王一横. All rights reserved.
//

#import "CCEmojiView.h"
#import "Emoji.h"


#define KMargin         5
#define KEmojiSize      40

@implementation CCEmojiView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        emojis = [NSArray arrayWithArray:[Emoji allEmoji]];
        contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-30)];
        contentView.delegate = self;
        contentView.backgroundColor = [UIColor clearColor];
        contentView.showsVerticalScrollIndicator = NO;
        CGFloat W = frame.size.width;
        CGFloat M = KMargin;
        CGFloat S = KEmojiSize;
        
        NSInteger X = (W - M) / (S + M);
        NSInteger emojiCount = emojis.count;
        NSInteger onePageX = X*4;
        NSInteger pageCount = emojiCount/onePageX;
        
        contentView.pagingEnabled = YES;
        contentView.contentSize = CGSizeMake(frame.size.width*pageCount, contentView.frame.size.height);
        for (int i = 0; i < pageCount; i ++) {
            UIView * pageView = [[UIView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, contentView.frame.size.height)];
            pageView.backgroundColor = [UIColor clearColor];
            [contentView addSubview:pageView];
            for (int j = 0; j < onePageX; j++) {
                CGFloat XR = (j % X) * S + ((j % X + 1) * M);
                NSInteger lineNumber = (j) / X;
                CGFloat YR = (lineNumber * S) + (lineNumber + 1) * M;
                
                NSInteger emojiId = (i * onePageX) + j;
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundColor:[UIColor clearColor]];
                [button setFrame:CGRectMake(XR, YR, S, S)];
                button.tag = emojiId;
                button.backgroundColor = [UIColor clearColor];
                [button addTarget:self action:@selector(emojiButton:) forControlEvents:UIControlEventTouchUpInside];
                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:27.0]];
                [button setTitle: [emojis objectAtIndex:emojiId]forState:UIControlStateNormal];
                [pageView addSubview:button];
            }
        }
        [self addSubview:contentView];
        
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, contentView.frame.size.height-5, frame.size.width, 30)];
        [pageControl setCurrentPage:0];
        pageControl.numberOfPages = pageCount;
        [pageControl setBackgroundColor:[UIColor clearColor]];
        [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton * deleteBu = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBu.frame = CGRectMake(15, self.bounds.size.height-35, 40, 30);
        [deleteBu setImage:[UIImage imageNamed:@"del_emoji_normal"] forState:UIControlStateNormal];
        [deleteBu setImage:[UIImage imageNamed:@"del_emoji_select"] forState:UIControlStateHighlighted ];
        [deleteBu addTarget:self action:@selector(deleteEmoji) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBu];
        deleteBu.backgroundColor = [UIColor clearColor];
        
        UIButton * sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame = CGRectMake(self.bounds.size.width - 60 - 15, self.bounds.size.height-35, 60, 30);
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        sendButton.layer.borderWidth = 0.6;
        sendButton.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:sendButton];
        
    }
    return self;
}
- (void)send{
    NSLog(@"send");
    if (_delegate) {
        [_delegate emojiSend];
    }
}
- (void)deleteEmoji{
    NSLog(@"delete");
    if (_delegate) {
        [_delegate selectedDelete];
    }
}
- (void)emojiButton:(UIButton *)button{
    NSLog(@"emoji %@",emojis[button.tag]);
    if (_delegate) {
        [_delegate selectedEmoji:emojis[button.tag]];
    }
}
- (void)changePage:(id)sender{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [pageControl setCurrentPage: (scrollView.contentOffset.x/self.bounds.size.width)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
