//
//  RMUpdateDetection.h
//  RMCollection
//
//  Created by Raffael Hannemann on 18.03.13.
//  Copyright (c) 2013 Raffael Hannemann. All rights reserved.
//

#import <Foundation/Foundation.h>
/** Requires @danhaly's Version Comparator lib from, e.g., https://github.com/danhanly/VersionComparator */
#import "VersionComparator.h"

/** The last version string will be written into the NSUserDefaults under the following key. */
#define kRMUpdateDetectionDefaultAppVersionPrefKey @"RMUpdateDetectionPrefsForAppVersion"

/** The following procotol must be implemented by the delegate of the Update Detection mechanism, e.g., by the AppDelegate object. */
@protocol RMUpdateDetectionDelegate <NSObject>
/**	Will be called once the user is running an app version higher than the last one stored. Updates the stored version afterwards. */
- (void) userDidUpdateFrom: (NSString *) oldVersion to: (NSString *) currentVersion;
@optional

/** Will be called if the user did not update the app version since the last app stars. */
- (void) userDidNotUpdate;

/** Will be called if the detection failed, e.g. because of not existing preference key, and only if the raiseErrorIfLastVersionIsNotStored property is set to YES. Won't then write the current version to the prefs. Instead, the developer has to handle the error and call [RMUpdateDetection writeVersion]; manually. */
- (void) updateDetectionDidFail: (NSError *) theError;

@end

@interface RMUpdateDetection : NSObject
@property (weak) id<RMUpdateDetectionDelegate> delegate;
@property (copy) NSString* appVersionPrefKey;

/** If set, no error will be raised if no previous app version could be read from the NSUserDefaults. Also, if set, the current version will not be written to the NSUserDefaults automatically, instead you would have to call -writeVersion; manually while handling the error. */
@property (assign) BOOL raiseErrorIfLastVersionIsNotStored;
+ (RMUpdateDetection *) sharedInstance;

/** Triggers the checking mechanism. Ideally, call this method in your -applicationDidFinishLoading; method. Be sure to have set the delegate before. */
- (void) check;

/** Manually write the app version (retrieved from the bundle) to the NSUserDefaults. */
- (void) writeVersion;

/** Retrieves the string of the current version. */
- (NSString *) currentVersion;

@end
