//
//  ViewController.m
//  TestVideoPlay
//
//  Created by wenyihui on 15/10/24.
//  Copyright (c) 2015年 GIT. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property(nonatomic,strong) MPMoviePlayerController *movewController;

@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *videoLink = @"http://221.236.173.19:8001/File/video/2015102304333620151023x5.mp4";
    [self createMPPlayerController:videoLink];
    
    
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(100, 100, 40, 40);
    self.indicatorView.hidesWhenStopped = YES;
    self.indicatorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    //self.indicatorView.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieLoadStateDidChange:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    
    
    UIButton *btnFullScreen = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnFullScreen.frame = CGRectMake(200, 350, 60, 40);
    [btnFullScreen addTarget:self action:@selector(clickFullScreen:) forControlEvents:UIControlEventTouchUpInside];
    [btnFullScreen setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:btnFullScreen];
    
    
    
    
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.indicatorView.center = self.movewController.view.center;
}

- (void)clickFullScreen:(UIButton *)sender
{
    [self.movewController setFullscreen:YES animated:YES];
}

- (void)createMPPlayerController:(NSString *)sFileNamePath {
    
    NSURL *movieURL = [NSURL URLWithString:sFileNamePath];
    
    NSParameterAssert([movieURL isKindOfClass:[NSURL class]]);
    
    self.movewController =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    
    [self.movewController prepareToPlay];
//    [movewController setControlStyle:MPMovieControlStyleDefault];
//    
//    [self.movewController setFullscreen:YES animated:YES];
    
    [self.movewController.view setFrame:CGRectMake(10, 40, self.view.bounds.size.width-20, 300)];
   // movewController.view.backgroundColor = [UIColor redColor];
    
    self.movewController.scalingMode = MPMovieScalingModeAspectFit;
    
    
    [self.view addSubview:self.movewController.view];//设置写在添加之后   // 这里是addSubView
    
    [self.movewController play];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //
    //                                             selector:@selector(movieFinishedCallback:)
    //
    //                                                 name:MPMoviePlayerPlaybackDidFinishNotification
    //
    //                                               object:movewController]; //播放完后的通知
    
    
    
}


#pragma mark - nocation
- (void)movieLoadStateDidChange:(NSNotification *)notification
{
    if (self.movewController.loadState & MPMovieLoadStateStalled)
    {
            self.indicatorView.hidden = NO;
            [self.indicatorView startAnimating];
    }
    else if (self.movewController.loadState & MPMovieLoadStatePlaythroughOK||
             self.movewController.loadState &MPMovieLoadStatePlayable)
    {
        self.indicatorView.hidden = YES;
        [self.indicatorView stopAnimating];

    }
}


//
//- (void)createMPPlayerController:(NSString *)sFileNamePath {
//
//    MPMoviePlayerViewController *moviePlayer =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:sFileNamePath]];
//
//    [moviePlayer.moviePlayer prepareToPlay];
//
//    [self presentMoviePlayerViewControllerAnimated:moviePlayer]; // 这里是presentMoviePlayerViewControllerAnimated
//
//    [moviePlayer.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
//
//    [moviePlayer.view setBackgroundColor:[UIColor clearColor]];
//
//    [moviePlayer.view setFrame:self.view.bounds];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//
//                                            selector:@selector(movieFinishedCallback:)
//
//                                                name:MPMoviePlayerPlaybackDidFinishNotification
//
//                                              object:moviePlayer.moviePlayer];
//
//
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
