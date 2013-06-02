//
//  DUTUtility+Localization.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/16/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility+Localization.h"
#import "DUTUtility+FileOperations.h"
#import "NSData+Document.h"

static NSDictionary *sLocaleData = nil;
@implementation DUTUtility (Localization)

+ (void)load {
    NSError *error;
    [DUTUtility createDocumentDirectory];
    NSData *binJSONData =
        [DUTUtility dataFromDocument:[self localizationFileName]];


    if (![binJSONData length]) {
        error = [self createLocalizationFileWithBuiltinLocalization];
    }
    else {
        sLocaleData =
            [NSJSONSerialization JSONObjectWithData:binJSONData options:0 error:&error];
        NSDictionary *bundleDict = [self localizationDictFromBundle];
        if (bundleDict) {
            NSString *bundleLocVersion = bundleDict[@"VERSION"];
            if (bundleLocVersion.integerValue > [self txtVersion].integerValue) {
                //Recreate file with localization in bundle
                error = [self createLocalizationFileWithBuiltinLocalization];
                sLocaleData = [self localizationDictFromBundle];
            }
        }
        NSLog(@"Read Locale data VERSION: %@\n%@",[self txtVersion],sLocaleData);
    }
}

+ (NSString *)localizedStringWithId:(NSString *)stringId {
    return sLocaleData[stringId];
}

+ (NSString *)txtVersion {
    return sLocaleData[@"VERSION"];
}

+ (NSError *)createLocalizationFileWithBuiltinLocalization {
    NSError *error;
    BOOL plistMissing = NO;
    NSDictionary *dict = [self localizationDictFromBundle];
    if (!dict) {
        plistMissing = YES;
        dict = [self systemDefaultLocalizationDictFromBundle];
    }
    NSLog(@"Writing Locale data %@",dict);
    NSData *binJSONData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    [binJSONData writeToDocument:plistMissing ? [self systemDefaultLocalizationFileName]:[self localizationFileName]];
    sLocaleData =
        [NSJSONSerialization JSONObjectWithData:binJSONData options:0 error:&error];
    return error;
}

+ (NSDictionary *)localizationDictFromBundle {
    NSURL *bundleLocalizationFile =
        [[NSBundle mainBundle]URLForResource:[self localizationFileName]  withExtension:@"plist"];
    if (!bundleLocalizationFile) {
        return nil;
    }
    NSDictionary *dict =
        [[NSDictionary alloc]initWithContentsOfURL:bundleLocalizationFile];
    return dict;
}

+ (NSString *)currentLanguage {
    NSString *languageCode =
        [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    return languageCode;
}

+ (NSString *)localizationFileName {
    return [NSString stringWithFormat:@"localizedtext_%@",[self currentLanguage]];
}

+ (NSString *)systemDefaultLocalizationFileName {
    return @"localizedtext_en";
}

+ (NSDictionary *)systemDefaultLocalizationDictFromBundle {
    NSURL *bundleLocalizationFile =
    [[NSBundle mainBundle]URLForResource:[self systemDefaultLocalizationFileName]  withExtension:@"plist"];
    if (!bundleLocalizationFile) {
        return nil;
    }
    NSDictionary *dict =
    [[NSDictionary alloc]initWithContentsOfURL:bundleLocalizationFile];
    return dict;
}

#pragma mark - Currency


+ (NSString *)currentLocaleCurrencySymbol {
    NSLocale *currentLocale = [NSLocale currentLocale];
    return [currentLocale objectForKey:NSLocaleCurrencySymbol];
}


+ (NSString *)currencySymbolForCurrencyCode:(NSString *)currencyCode {
    if (!currencyCode) {
        return [self currentLocaleCurrencySymbol];
    }
    NSSet *localeIds = [NSSet setWithArray:[NSLocale availableLocaleIdentifiers]];
    NSSet *match = [localeIds objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        NSString *localeId = obj;
        BOOL passed = NO;
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:localeId];
        NSString *localeCurrencyCode = [locale objectForKey:NSLocaleCurrencyCode];
        if ([currencyCode isEqualToString:localeCurrencyCode]) {
            *stop = YES;
            passed = YES;
        }
        return passed;
    }];
    NSString *localeId = [match anyObject];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:localeId];
    return [locale objectForKey:NSLocaleCurrencySymbol];
}


@end
