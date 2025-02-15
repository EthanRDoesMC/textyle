#import "TXTListController.h"
#import <Preferences/PSSpecifier.h>

@implementation TXTListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIColor *tintColor = [UIColor colorWithRed:1.00 green:0.18 blue:0.33 alpha:0.85f];
    settingsView = [[[UIApplication sharedApplication] windows] firstObject];

    settingsView.tintColor = tintColor;
    [UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]].onTintColor = tintColor;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    settingsView.tintColor = nil;
}

- (id)readPreferenceValue:(PSSpecifier *)specifier {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];

    if (![prefs objectForKey:[specifier.properties objectForKey:@"key"]]) {
        return [specifier.properties objectForKey:@"default"];
    }

    return [prefs objectForKey:[specifier.properties objectForKey:@"key"]];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];

    [prefs setObject:value forKey:[specifier.properties objectForKey:@"key"]];
    [prefs writeToFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]] atomically:YES];
    [prefs release];

    if ([specifier.properties objectForKey:@"PostNotification"]) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)[specifier.properties objectForKey:@"PostNotification"], NULL, NULL, YES);
    }

    [super setPreferenceValue:value specifier:specifier];
}

@end
