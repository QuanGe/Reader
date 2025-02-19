//
//  LSYMenuView.m
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYMenuView.h"
#import "LSYTopMenuView.h"
#import "LSYBottomMenuView.h"
#define AnimationDelay 0.3f
#define TopViewHeight 64.0f
#define BottomViewHeight 200.0f
@interface LSYMenuView ()<LSYMenuViewDelegate>

@end
@implementation LSYMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40 + [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top);
    }];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(90 + [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom);
    }];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}
-(LSYTopMenuView *)topView
{
    if (!_topView) {
        _topView = [[LSYTopMenuView alloc] initWithFrame:CGRectMake(0, -TopViewHeight, ViewSize(self).width,TopViewHeight)];
        _topView.delegate = self;
    }
    return _topView;
}
-(LSYBottomMenuView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LSYBottomMenuView alloc] initWithFrame:CGRectMake(0, ViewSize(self).height, ViewSize(self).width,BottomViewHeight)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
-(void)setRecordModel:(LSYRecordModel *)recordModel
{
    _recordModel = recordModel;
    _bottomView.readModel = recordModel;
}
#pragma mark - LSYMenuViewDelegate

-(void)menuViewInvokeCatalog:(LSYBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:bottomMenu];
    }
}
-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
        [self.delegate menuViewJumpChapter:chapter page:page];
    }
}
-(void)menuViewFontSize:(LSYBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:bottomMenu];
    }
}
-(void)menuViewMark:(LSYTopMenuView *)topMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewMark:)]) {
        [self.delegate menuViewMark:topMenu];
    }
}
#pragma mark -
-(void)hiddenSelf
{
    [self hiddenAnimation:YES];
}
-(void)showAnimation:(BOOL)animation
{
    self.hidden = NO;

    if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
        [self.delegate menuViewDidAppear:self];
    }
}
-(void)hiddenAnimation:(BOOL)animation
{
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
        [self.delegate menuViewDidHidden:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}
@end
