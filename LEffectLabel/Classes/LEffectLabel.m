#import "LEffectLabel.h"
#import <QuartzCore/QuartzCore.h>


@interface UIImage (LEffectLabelAdditions)


+ (UIImage *)imageWithView:(UIView *)view;


@end


@implementation LEffectLabel


#pragma mark - Init


- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (void)initialize
{
    _textColor = [UIColor whiteColor];
    _effectColor = [UIColor redColor];
    
    _effectLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _effectLabel.textAlignment = NSTextAlignmentLeft;
    _effectLabel.numberOfLines = 1;
    _effectLabel.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    gradientLayer.backgroundColor = [[UIColor clearColor] CGColor];
}


#pragma mark - layoutSubviews


- (void)layoutSubviews
{
    _textLayer.frame = self.bounds;
}


#pragma mark layerClass


+ (Class)layerClass
{
    return [CAGradientLayer class];
}


#pragma mark - Setters


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _effectLabel.frame = frame;
}


- (void)setFont:(UIFont *)font
{
    _font = font;
    _effectLabel.font = _font;
    
    [self updateLabel];
}


- (void)setText:(NSString *)text
{
    _text = text;
    _effectLabel.text = _text;
    
    [self updateLabel];
}


- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _effectLabel.textColor = _textColor;
    
    [self updateLabel];
}


#pragma mark - Update UI


- (void)updateLabel
{
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    gradientLayer.colors = [self colorsForStage:0];
    
    [_effectLabel sizeToFit];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _effectLabel.frame.size.width, _effectLabel.frame.size.height);
    
    _alphaImage = [[UIImage imageWithView:_effectLabel] CGImage];
    
    _textLayer = [CALayer layer];
    _textLayer.contents = (__bridge id)_alphaImage;
    
    [self.layer setMask:_textLayer];
    
    [self setNeedsLayout];
}


#pragma mark - Effect animation


- (void)performEffectAnimation
{
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    
    gradientLayer.colors = [self colorsForStage:0];
    
    switch (_effectDirection)
    {
        case EffectDirectionLeftToRight:
            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
            break;
        case EffectDirectionRightToLeft:
            gradientLayer.startPoint = CGPointMake(1.0, 0.5);
            gradientLayer.endPoint = CGPointMake(0.0, 0.5);
            break;
        case EffectDirectionTopToBottom:
            gradientLayer.startPoint = CGPointMake(0.5, 0.0);
            gradientLayer.endPoint = CGPointMake(0.5, 1.0);
            break;
        case EffectDirectionBottomToTop:
            gradientLayer.startPoint = CGPointMake(0.5, 1.0);
            gradientLayer.endPoint = CGPointMake(0.5, 0.0);
            break;
        case EffectDirectionBottomLeftToTopRight:
            gradientLayer.startPoint = CGPointMake(0.0, 1.0);
            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
            break;
        case EffectDirectionBottomRightToTopLeft:
            gradientLayer.startPoint = CGPointMake(1.0, 1.0);
            gradientLayer.endPoint = CGPointMake(0.0, 0.0);
            break;
        case EffectDirectionTopLeftToBottomRight:
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            break;
        case EffectDirectionTopRightToBottomLeft:
            gradientLayer.startPoint = CGPointMake(1.0, 0.0);
            gradientLayer.endPoint = CGPointMake(0.0, 1.0);
            break;
    }
    
    CABasicAnimation *animation0 = [self animationForStage:0];
    CABasicAnimation *animation1 = [self animationForStage:1];
    CABasicAnimation *animation2 = [self animationForStage:2];
    CABasicAnimation *animation3 = [self animationForStage:3];
    CABasicAnimation *animation4 = [self animationForStage:4];
    CABasicAnimation *animation5 = [self animationForStage:5];
    CABasicAnimation *animation6 = [self animationForStage:6];
    CABasicAnimation *animation7 = [self animationForStage:7];
    CABasicAnimation *animation8 = [self animationForStage:8];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = animation8.beginTime + animation8.duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:@[animation0, animation1, animation2, animation3, animation4, animation5, animation6, animation7, animation8]];
    
    [gradientLayer addAnimation:group forKey:@"animationOpacity"];
}


#pragma mark - Animations


- (CABasicAnimation *)animationForStage:(NSUInteger)stage
{
    CGFloat duration = 0.3;
    CGFloat inset = 0.1;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    
    animation.fromValue = [self colorsForStage:stage];
    animation.toValue = [self colorsForStage:stage + 1];
    animation.beginTime = stage * (duration - inset);
    animation.duration = duration;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return animation;
}


#pragma mark - Colors


- (NSArray *)colorsForStage:(NSUInteger)stage
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:8];
    
    for (int i = 0; i < 9; i++)
    {
        [array addObject:stage != 0 && stage == i ? (id)[_effectColor CGColor] : (id)[_textColor CGColor]];
    }
    
    return [NSArray arrayWithArray:array];
}


#pragma mark -


@end


@implementation UIImage (LEffectLabelAdditions)


+ (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end