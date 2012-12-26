#import "ViewController.h"


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    LEffectLabel *effectLabel = [[LEffectLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
    [self.view addSubview:effectLabel];
    effectLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    effectLabel.font = [UIFont boldSystemFontOfSize:28];
    effectLabel.text = @"LEffectLabel";
    
    effectLabel.textColor = [UIColor whiteColor];
    effectLabel.effectColor = [UIColor redColor];
    effectLabel.effectDirection = EffectDirectionTopLeftToBottomRight;
    
    effectLabel.center = self.view.center;
    
    for (int i = 0; i < 8; i++)
    {
        int64_t delayInSeconds = 3 * i;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            effectLabel.effectDirection = i;
            [effectLabel performEffectAnimation];
        });
    }
}


@end