//
// Created by stone on 2019-03-28.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "T007ViewController.h"

static void* playerContext = &playerContext;

@interface T007ViewController ()

@property(nonatomic, strong) AVPlayer* player;
@property(assign, nonatomic) BOOL isPlaying;
@end

@implementation T007ViewController {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  // NSString *scale    = [NSString stringWithFormat:@"@%li", (NSInteger)
  // [UIScreen mainScreen].scale];
  NSString* resource = [NSString
      stringWithFormat:@"music.bundle/%@", @"01 Wicked Wonderland.mp3"];
  NSString* path = [[NSBundle mainBundle] pathForResource:resource ofType:nil];
  NSURL* url = [NSURL fileURLWithPath:path];
  AVPlayerItem* item = [[AVPlayerItem alloc] initWithURL:url];
  self.player = [[AVPlayer alloc] initWithPlayerItem:item];

  [self.player
      addObserver:self
       forKeyPath:@"timeControlStatus"
          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
          context:playerContext];
}

- (void)
observeValueForKeyPath:(nullable NSString*)keyPath
              ofObject:(nullable id)object
                change:(nullable NSDictionary<NSKeyValueChangeKey, id>*)change
               context:(nullable void*)context {
  if (context == playerContext) {
    // NSLog(@"监听到 %@  %@  %@", keyPath, object,
    // change[NSKeyValueChangeNewKey]);
    if (@available(iOS 10.0, *)) {
      AVPlayerTimeControlStatus status = (AVPlayerTimeControlStatus)
          [change[NSKeyValueChangeNewKey] integerValue];
      NSLog(@"status = %ld", status);
      //     /**
      //     当播放`rate`变为0.0时，进入此状态.此更改可能是调用`pause`方法或
      //     更改播放的`rate`属性为0.0的结果，但也可能由于外部事件（如iOS中断）
      //     而发生。在这种状态下，播放会无限期地暂停，直到播放速率变为大于0.0的
      //     值: 接收到具有非零值的-setRate：或-playImmediatelyAtRate：，
      //     并且有足够的媒体数据已被缓冲以进行播放为止。
      //     */
      //     AVPlayerTimeControlStatusPaused,
      //
      //    /**
      //     当播放器在AVPlayerTimeControlStatusPlaying状态下因为播放缓冲器
      //     变空而播放停止时或者在AVPlayerTimeControlStatusPaused状态下，播
      //     放速度从0.0被设置为其他值但是并没有足够的媒体数据已经被缓冲可以用来进
      //     行播放时或者播放器没有Item去进行播放时，即player的currentItem为nil
      //     时会进入此状态。在等待缓冲时，可以尝试通过 -playImmediatelyAtRate:
      //     方法开始播放任何其他可用的媒体数据。
      //     */
      //     AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate,
      //
      //    /**
      //     在这种状态下，播放正在进行，速率（rate）的更改将立即生效。
      //     如果因为媒体
      //     数据不足而播放失败，则timeControlStatus的属性值将更改为
      //     AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate
      //     */
      //     AVPlayerTimeControlStatusPlaying
    } else {
      // Fallback on earlier versions
      // ios10.0之后才能够监听到暂停后继续播放的状态，ios10.0之前监测不到这个状态
      //但是可以监听到开始播放的状态 AVPlayerStatus  status监听这个属性。
    }
  }
}

- (void)dealloc {
  @try {
    [self.player removeObserver:self forKeyPath:@"timeControlStatus"];
  } @catch (NSException* exception) {
    NSLog(@"多次删除了");
  }
}
// https://stackoverflow.com/questions/7575494/avplayer-notification-for-play-pause-state
- (void)playMusic {
  // 调节速率
  self.player.rate = 2.0;
  if (self.player.timeControlStatus == AVPlayerTimeControlStatusPaused) {
    // Paused mode
    [self.player play];
  } else if (self.player.timeControlStatus ==
             AVPlayerTimeControlStatusPlaying) {
    // Play mode
    [self.player pause];
  }
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches
           withEvent:(nullable UIEvent*)event {
  [self playMusic];
}

@end
