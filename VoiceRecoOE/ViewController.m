//
//  ViewController.m
//  VoiceRecoOE
//
//  Created by Beto Lucena on 2014-10-14.
//  Copyright (c) 2014 Beto Lucena. All rights reserved.
//

#import "ViewController.h"
#import <OpenEars/LanguageModelGenerator.h>
@interface ViewController ()

@end

@implementation ViewController
@synthesize pocketsphinxController;
@synthesize openEarsEventsObserver;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.openEarsEventsObserver setDelegate:self];
    [self.pocketsphinxController startListeningWithLanguageModelAtPath:@"sf" dictionaryAtPath:@"D" acousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to perform Spanish recognition instead of English.
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) GeraModelo
{
    LanguageModelGenerator *lmGenerator=[[LanguageModelGenerator alloc] init];
    NSArray *words = [NSArray arrayWithObjects:@"WORD", @"STATEMENT", @"OTHER WORD", @"A PHRASE", nil];
    NSString *name = @"NameIWantForMyLanguageModelFiles";
   NSError *err = [lmGenerator generateLanguageModelFromArray:words withFilesNamed:name forAcousticModelAtPath:@"AcousticModelEnglish"];
    
    NSDictionary *languageGeneratorResults = nil;
    
    NSString *lmPath = nil;
    NSString *dicPath = nil;
    
    if([err code] == noErr) {
        
        languageGeneratorResults = [err userInfo];
        
        lmPath = [languageGeneratorResults objectForKey:@"LMPath"];
        dicPath = [languageGeneratorResults objectForKey:@"DictionaryPath"];
        
    } else {
        NSLog(@"Error: %@",[err localizedDescription]);
    }
    
}
- (PocketsphinxController *)pocketsphinxController {
    if (pocketsphinxController == nil) {
        pocketsphinxController = [[PocketsphinxController alloc] init];
    }
    return pocketsphinxController;
}
- (OpenEarsEventsObserver *)openEarsEventsObserver {
    if (openEarsEventsObserver == nil) {
        openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
    }
    return openEarsEventsObserver;
    
}

- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
}

- (void) pocketsphinxDidStartCalibration {
    NSLog(@"Pocketsphinx calibration has started.");
}

- (void) pocketsphinxDidCompleteCalibration {
    NSLog(@"Pocketsphinx calibration is complete.");
}

- (void) pocketsphinxDidStartListening {
    NSLog(@"Pocketsphinx is now listening.");
}

- (void) pocketsphinxDidDetectSpeech {
    NSLog(@"Pocketsphinx has detected speech.");
}

- (void) pocketsphinxDidDetectFinishedSpeech {
    NSLog(@"Pocketsphinx has detected a period of silence, concluding an utterance.");
}

- (void) pocketsphinxDidStopListening {
    NSLog(@"Pocketsphinx has stopped listening.");
}

- (void) pocketsphinxDidSuspendRecognition {
    NSLog(@"Pocketsphinx has suspended recognition.");
}

- (void) pocketsphinxDidResumeRecognition {
    NSLog(@"Pocketsphinx has resumed recognition.");
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
    NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) pocketSphinxContinuousSetupDidFail { // This can let you know that something went wrong with the recognition loop startup. Turn on OPENEARSLOGGING to learn why.
    NSLog(@"Setting up the continuous recognition loop has failed for some reason, please turn on OpenEarsLogging to learn more.");
}
- (void) testRecognitionCompleted {
    NSLog(@"A test file that was submitted for recognition is now complete.");

}

@end

