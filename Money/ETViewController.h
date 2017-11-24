//
//  ETViewController.h
//  Money
//

//  Copyright (c) 2014 Erlend Thune. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>

@interface ETViewController : UIViewController<ADBannerViewDelegate>
@property (strong, nonatomic) ADBannerView *_bannerView;
@property (weak, nonatomic) IBOutlet UIButton *pausePlayButton;
@property (strong, nonatomic) UIImage *playImage;
@property (strong, nonatomic) UIImage *pauseImage;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (strong, nonatomic) UIImage *audioOnImage;
@property (strong, nonatomic) UIImage *audioOffImage;
@end
