//
//  ViewController.m
//  MediaPayerTest
//
//  Created by chrisfnxu on 5/6/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"
@import MediaPlayer;
@import AVKit;
@import AVFoundation;

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *videoVIew;
@property (strong, nonatomic) MPMoviePlayerController* mc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self registerNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSURL *videoUrl = [[NSURL alloc] initWithString:@"http://183.57.53.27/vcloud.tc.qq.com/1033_6fc864d387544ed89b6b9d0ce454a22a.f20.mp4?vkey=119BA008302E647553811484E47D12DE8AD4F1B9313DDE355C801F8952779D4EAD798DAA604D299F"];
    NSLog(@"videoUrl: %@", videoUrl);
    
//    if (0) {
//        AVPlayer *player = [[AVPlayer alloc] initWithURL:videoUrl];
//        AVPlayerViewController *playerController = [[AVPlayerViewController alloc] init];
//        
//        playerController.player = player;
//        [self addChildViewController:playerController];
//        [self.videoVIew addSubview:playerController.view];
//        playerController.view.frame = self.videoVIew.frame;
//        playerController.videoGravity = AVLayerVideoGravityResizeAspect;
//        self.view.autoresizesSubviews = TRUE;
//        
//        [player play];
//    }
    
    if (1) {
        MPMoviePlayerController *playerViewController = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
        self.mc = playerViewController;
        
//        playerViewController.movieSourceType = MPMovieSourceTypeStreaming;
//        playerViewController.scalingMode = MPMovieScalingModeAspectFill;
//        playerViewController.controlStyle = MPMovieControlStyleNone;
        playerViewController.fullscreen = NO;
        playerViewController.allowsAirPlay = NO;
        playerViewController.shouldAutoplay = NO;
        playerViewController.repeatMode = MPMovieRepeatModeNone;
        
//        [self.navigationController presentMoviePlayerViewControllerAnimated:playerViewController];
        
        [playerViewController.view setFrame:self.videoVIew.bounds];
        [self.videoVIew addSubview:playerViewController.view];
        
        [playerViewController play];
    }
    
}

- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scalingModeDidChangeNotification:) name:MPMoviePlayerScalingModeDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinishReasonUserInfoKey:) name:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateDidChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStateDidChangeNotification:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingMovieDidChangeNotification:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterFullscreenNotification:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterFullscreenNotification:) name:MPMoviePlayerDidEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitFullscreenNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didExitFullscreenNotification:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullscreenAnimationDurationUserInfoKey:) name:MPMoviePlayerFullscreenAnimationDurationUserInfoKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullscreenAnimationCurveUserInfoKey:) name:MPMoviePlayerFullscreenAnimationCurveUserInfoKey object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isAirPlayVideoActiveDidChangeNotification:) name:MPMoviePlayerIsAirPlayVideoActiveDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readyForDisplayDidChangeNotification:) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sourceTypeAvailableNotification:) name:MPMovieSourceTypeAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(durationAvailableNotification:) name:MPMovieDurationAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(naturalSizeAvailableNotification:) name:MPMovieNaturalSizeAvailableNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackIsPreparedToPlayDidChangeNotification:) name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


#pragma mark -
#pragma mark - notification

- (void)playbackIsPreparedToPlayDidChangeNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"playbackIsPreparedToPlayDidChangeNotification");
    NSLog(@"last log");
}

- (void)scalingModeDidChangeNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"scalingModeDidChangeNotification: scalingMode:%ld", (long)player.scalingMode);
    NSLog(@"last log");
}


- (void)playbackDidFinishNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"playbackDidFinishNotification");
    NSLog(@"last log");
}


- (void)playbackDidFinishReasonUserInfoKey:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"playbackDidFinishReasonUserInfoKey");
    NSLog(@"last log");
}


- (void)playbackStateDidChangeNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"playbackStateDidChangeNotification, playbackStatus:%ld", (long)player.playbackState);
    NSLog(@"last log");
}


- (void)loadStateDidChangeNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"loadStateDidChangeNotification");
    
    //    if (player.loadState & MPMovieLoadStatePlayable)
    //    {
    //        NSLog(@"Movie is Ready to Play");
    //        [player play];
    //    }
    NSLog(@"last log");
}


- (void)playingMovieDidChangeNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"playingMovieDidChangeNotification, contentUrl:%@. %@", player.contentURL, player.accessLog);
    NSLog(@"last log");
}


- (void)willEnterFullscreenNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"willEnterFullscreenNotification");
    NSLog(@"last log");
}


- (void)didEnterFullscreenNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"didEnterFullscreenNotification");
    NSLog(@"last log");
}


- (void)willExitFullscreenNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"willExitFullscreenNotification");
    NSLog(@"last log");
}


- (void)didExitFullscreenNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"didExitFullscreenNotification");
    NSLog(@"last log");
}


- (void)fullscreenAnimationDurationUserInfoKey:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"fullscreenAnimationDurationUserInfoKey");
    NSLog(@"last log");
}


- (void)fullscreenAnimationCurveUserInfoKey:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"fullscreenAnimationCurveUserInfoKey");
    NSLog(@"last log");
}


- (void)isAirPlayVideoActiveDidChangeNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"isAirPlayVideoActiveDidChangeNotification");
    NSLog(@"last log");
}


- (void)readyForDisplayDidChangeNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"readyForDisplayDidChangeNotification");
    NSLog(@"last log");
}


- (void)sourceTypeAvailableNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"sourceTypeAvailableNotification");
    NSLog(@"last log");
}

- (void)durationAvailableNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"durationAvailableNotification");
    NSLog(@"last log");
}

- (void)naturalSizeAvailableNotification:(NSNotification *)notification
{
    MPMoviePlayerController* player = [notification object];
    NSLog(@"naturalSizeAvailableNotification");
    NSLog(@"last log");
}
@end
