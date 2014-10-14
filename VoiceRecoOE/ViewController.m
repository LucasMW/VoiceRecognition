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
- (void)viewDidLoad {
    [super viewDidLoad];
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
@end

