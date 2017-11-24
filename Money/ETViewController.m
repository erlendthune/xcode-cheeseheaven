//
//  ETViewController.m
//  Money
//
//  Created by Erlend Thune on 24.05.14.
//  Copyright (c) 2014 Erlend Thune. All rights reserved.
//

#import "ETViewController.h"
#import "ETMyScene.h"
@interface ETViewController ()

@property (nonatomic, strong) IBOutlet UIView *contentView;

// contentView's vertical bottom constraint, used to alter the contentView's vertical size when ads arrive
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bottomConstraint;
@end

@implementation ETViewController
{
    ETMyScene* _scene;
    bool _bGameInitialized;
    bool _bviewWillLayoutSubviewsCalled;
    bool _blayoutAnimatedCalled;
}
- (IBAction)audioButtonPushed:(id)sender {
    NSLog(@"audioButtonPushed");
    if([_scene audioOnOff])
    {
        [self.soundButton setImage:self.audioOnImage forState:UIControlStateNormal];
    }
    else
    {
        [self.soundButton setImage:self.audioOffImage forState:UIControlStateNormal];
    }
}
- (IBAction)pausePlayButtonPressed:(id)sender {
    NSLog(@"pausePlayButtonPressed");
    if([_scene pausePlayGame])
    {
        [self.pausePlayButton setImage:self.playImage forState:UIControlStateNormal];
    }
    else
    {
        [self.pausePlayButton setImage:self.pauseImage forState:UIControlStateNormal];
    }
}

/*
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [ETMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    self._bannerView = nil;
    _bGameInitialized = NO;
    _blayoutAnimatedCalled = NO;
    _bviewWillLayoutSubviewsCalled = NO;
    
}

- (void)layoutAnimated:(BOOL)animated
{
    CGRect contentFrame = self.view.bounds;
    
    // all we need to do is ask the banner for a size that fits into the layout area we are using
    CGSize sizeForBanner = [self._bannerView sizeThatFits:contentFrame.size];
    _scene.yoff = sizeForBanner.height;
    
    // compute the ad banner frame
    CGRect bannerFrame = self._bannerView.frame;
    if (self._bannerView.bannerLoaded) {
        
        // bring the ad into view
        contentFrame.size.height -= sizeForBanner.height;   // shrink down content frame to fit the banner below it
        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.size.height = sizeForBanner.height;
        bannerFrame.size.width = sizeForBanner.width;
        
        // if the ad is available and loaded, shrink down the content frame to fit the banner below it,
        // we do this by modifying the vertical bottom constraint constant to equal the banner's height
        //
        NSLayoutConstraint *verticalBottomConstraint = self.bottomConstraint;
        verticalBottomConstraint.constant = sizeForBanner.height;
        [self.view layoutSubviews];
        
    } else {
        // hide the banner off screen further off the bottom
        bannerFrame.origin.y = contentFrame.size.height;
    }
    _contentView.frame = contentFrame;
    [_contentView layoutIfNeeded];
    self._bannerView.frame = bannerFrame;
    
    if(!_blayoutAnimatedCalled)
    {
        _blayoutAnimatedCalled = YES;
        if(!_bGameInitialized)
        {
            [_scene initGame:self];
            _bGameInitialized = YES;
        }
    }
/*
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        _contentView.frame = contentFrame;
        [_contentView layoutIfNeeded];
        _bannerView.frame = bannerFrame;
    }];
*/
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    if(!_bviewWillLayoutSubviewsCalled)
    {
        _bviewWillLayoutSubviewsCalled = YES;
        self.playImage = [UIImage imageNamed:@"play.png"];
        self.pauseImage = [UIImage imageNamed:@"pause.png"];
        self.audioOnImage = [UIImage imageNamed:@"audioon.png"];
        self.audioOffImage = [UIImage imageNamed:@"audiomute.png"];
        
        // Configure the view.
        SKView * skView = (SKView *)self.view;
        
        skView.showsFPS = NO;
        skView.showsNodeCount = NO;
        
        // Create and configure the scene.
        _scene = [ETMyScene sceneWithSize:skView.bounds.size];
        _scene.scaleMode = SKSceneScaleModeAspectFill;
        
        
        // Present the scene.
        [skView presentScene:_scene];
        
        // On iOS 6 ADBannerView introduces a new initializer, use it when available.
        if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
            self._bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        } else {
            self._bannerView = [[ADBannerView alloc] init];
        }
        self._bannerView.delegate = self;
        [self.view addSubview:self._bannerView];
    }
}
- (void)viewDidLayoutSubviews
{
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"didFailToReceiveAdWithError %@", error);
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"bannerViewActionShouldBegin willLeave:%d", willLeave);
    if(!_scene.bPause)
    {
        [_scene pauseGame];
    }
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    if(!_scene.bPause)
    {
        [_scene playGame];
    }
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    NSLog(@"Memory warning received");
}

@end
