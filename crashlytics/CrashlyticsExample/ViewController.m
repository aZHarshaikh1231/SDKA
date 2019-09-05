//
//  Copyright (c) 2018 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
@import Firebase;
@import FirebaseCrashlytics;

@interface ViewController ()

@property(nonatomic) FIRCrashlytics *crashlytics;

@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];

  self.crashlytics = [FIRCrashlytics crashlytics];

  // Log that the view did load.
  [_crashlytics logWithFormat:@"%@", @"View loaded"];

  [_crashlytics setCustomValue:3 forKey:@"current_level"];
  [_crashlytics setCustomValue:@"logged_in" forKey:@"last_UI_action"];
  [_crashlytics setUserID:@"123456789"];

  NSDictionary *userInfo = @{
                             NSLocalizedDescriptionKey: NSLocalizedString(@"The request failed.", nil),
                             NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The response returned a 404.", nil),
                             NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Does this page exist?", nil),
                             @"ProductID": @"123456",
                             @"UserID": @"Jane Smith"
                             };
  NSError *error = [NSError errorWithDomain:NSURLErrorDomain
                                       code:-1001
                                   userInfo:userInfo];
  [_crashlytics recordError:error];
}

- (IBAction)initiateCrash:(id)sender {
  // [START log_and_crash]
  [_crashlytics log:@"Cause Crash button clicked"];
  @[][1];
  // [END log_and_crash]
}

@end
