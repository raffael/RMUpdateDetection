//
//  RMUpdateDetection.m
//  RMCollection
//
//  Created by Raffael Hannemann on 18.03.13.
//  Copyright (c) 2013 Raffael Hannemann. All rights reserved.
//

#import "RMUpdateDetection.h"

static RMUpdateDetection *instance;

typedef enum{
	RMUpdateDetectionErrorAppVersionPrefKeyDoesNotExist
} kRMUpdateDetectionError;

@implementation RMUpdateDetection

+(instancetype) sharedInstance {
	if (instance==nil) instance = [[self alloc] init];
	return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.appVersionPrefKey = kRMUpdateDetectionDefaultAppVersionPrefKey;
    }
    return self;
}

- (void) check {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *prefsAreForVersion = [prefs objectForKey:self.appVersionPrefKey];
	NSString *currentVersion = [self currentVersion];

	if (prefsAreForVersion == nil) {
		if (self.raiseErrorIfLastVersionIsNotStored) {
			NSError *error = [NSError errorWithDomain:@"me.raffael.RMCollection.RMUpdateDetection" code:RMUpdateDetectionErrorAppVersionPrefKeyDoesNotExist userInfo:nil];
			if ([self.delegate respondsToSelector:@selector(updateDetectionDidFail:)])
				[self.delegate updateDetectionDidFail:error];
		} else {
			[prefs setObject:currentVersion forKey:self.appVersionPrefKey];
			if ([self.delegate respondsToSelector:@selector(userDidNotUpdate)])
				[self.delegate userDidNotUpdate];
		}
		return;
	}
	
	BOOL userDidUpdate = [VersionComparator isVersion:currentVersion greaterThanVersion:prefsAreForVersion];
	if (userDidUpdate) {
		[self.delegate userDidUpdateFrom:prefsAreForVersion to:currentVersion];
		[self writeVersion];
	} else {
		if ([self.delegate respondsToSelector:@selector(userDidNotUpdate)])
			[self.delegate userDidNotUpdate];
	}
}

- (NSString *) currentVersion {
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (void) writeVersion {
	[[NSUserDefaults standardUserDefaults] setObject:[self currentVersion] forKey:self.appVersionPrefKey];
}

@end
