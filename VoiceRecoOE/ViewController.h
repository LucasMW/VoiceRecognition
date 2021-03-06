//
//  ViewController.h
//  VoiceRecoOE
//
//  Created by Beto Lucena on 2014-10-14.
//  Copyright (c) 2014 Beto Lucena. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <OpenEars/OpenEarsEventsObserver.h>
#import <OpenEars/PocketsphinxController.h>
#import <OpenEars/AcousticModel.h>
#import <OpenEars/OpenEarsEventsObserver.h>
PocketsphinxController *pocketsphinxController;
OpenEarsEventsObserver *openEarsEventsObserver;
@interface ViewController : UIViewController <OpenEarsEventsObserverDelegate>

@property (strong, nonatomic) PocketsphinxController *pocketsphinxController;
@property (strong, nonatomic) OpenEarsEventsObserver *openEarsEventsObserver;
@end

