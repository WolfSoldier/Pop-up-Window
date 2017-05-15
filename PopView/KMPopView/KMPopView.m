//
//  KMPopView.m
//  MakerMap
//
//  Created by kevin on 16/3/26.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import "KMPopView.h"



@interface KMPopView()<UIGestureRecognizerDelegate>

@property (nonatomic,copy)PopViewBlock popBlock;


@property (nonatomic,strong)UIView *popView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UIButton *sureBtn;
@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,strong)UITapGestureRecognizer *cancelTap;


@end

@implementation KMPopView

#define popWidth (ScreenWidth-60)
#define popHeight ((ScreenWidth-60)*315/339)
- (instancetype)init
{
    @throw  [NSException exceptionWithName:@"Use initSuperWithBlock" reason:@"" userInfo:nil];
    
    return nil;
}
- (instancetype)initSuperWithBlock:(PopViewBlock)block
{
    if (self = [super init]) {
        if (block) {
            _popBlock = block;
        }
        
        self.frame = CGRectMake(0, 0, ScreenWidth , ScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0];
        
        _popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popWidth, popHeight)];
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.clipsToBounds = YES;
        
        _popView.layer.cornerRadius = 5;
        
        [self addSubview:_popView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35,popWidth, 25)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = 1;
        [_popView  addSubview:_titleLabel];
        
        

        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20 , _titleLabel.bottom +24, popWidth - 40,100)];
        
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor blackColor];
        _textView.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        _textView.editable = NO;        //是否允许编辑内容，默认为“YES”
        _textView.userInteractionEnabled = NO;
        [_popView addSubview:_textView];
        
        
        for (NSInteger i = 0; i<2; i++) {
           UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(25,_textView.bottom+i*80, popWidth - 50, 45)];
            
            addBtn.clipsToBounds = YES;
            addBtn.layer.cornerRadius = 5;
            addBtn.tag = i;
            addBtn.backgroundColor = [UIColor greenColor];
            [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [_popView addSubview:addBtn];
            
            if (i == 0) {
                [addBtn setTitle:@"Sure" forState:UIControlStateNormal];
                _sureBtn = addBtn;
            }
            else    {
                [addBtn setTitle:@"Cancel" forState:UIControlStateNormal];
                _cancelBtn = addBtn;
            }
        }
        
        _cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedCancel)];
        _cancelTap.delegate = self;
        [self addGestureRecognizer:_cancelTap];
        
        
    }
    return self;
}
- (void)resetTitle:(NSString *)title text:(NSString *)text sureBtn:(NSString *)suerStr cancel:(NSString *)cancelStr canTapCancel:(BOOL)canTap
{
    
    _titleLabel.text = title;
    _textView.text = text;
    [_textView sizeToFit];
    _sureBtn.originY = _textView.bottom +15;
    
    [_sureBtn setTitle:suerStr forState:UIControlStateNormal];
    if (cancelStr) {
        _cancelBtn.hidden = NO;
        _cancelBtn.originY = _sureBtn.bottom +15;
        [_cancelBtn setTitle:cancelStr forState:UIControlStateNormal];
        
        _popView.sizeHeight = _cancelBtn.bottom + 25;
    }
    else
    {
        _cancelBtn.hidden = YES;
        _popView.sizeHeight = _sureBtn.bottom + 25;
    }

    _popView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);

    if (!canTap) {
        [self removeGestureRecognizer:_cancelTap];
    }
}
//0:SURE,1:CANCEL
+ (KMPopView *)popWithTitle:(NSString *)title text:(NSString *)text sureBtn:(NSString *)suerStr cancel:(NSString *)cancelStr block:(PopViewBlock)block canTapCancel:(BOOL)canTap
{
    
    KMPopView *view = [[KMPopView alloc]initSuperWithBlock:block];
    
    [view resetTitle:title text:text sureBtn:suerStr cancel:cancelStr canTapCancel:canTap];
    
    return view;
}
-(void)tappedCancel
{
    
    [UIView animateWithDuration:0.7f delay:0.f usingSpringWithDamping:.5f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _popView.transform = CGAffineTransformMakeScale(.8f, .8f);
        _popView.alpha = 0;
        _sureBtn.alpha = 0;
        _cancelBtn.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)clickBtn:(UIButton *)btn
{
    if (_popBlock) {
        _popBlock(btn.tag);
    }
    [self tappedCancel];
}
#pragma mark - show

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    _popView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _popView.alpha = 0;
    
    [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _popView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _sureBtn.alpha = 1;
        _cancelBtn.alpha = 1;
        _popView.alpha = 1.0;
        
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
    } completion:nil];
}

@end
