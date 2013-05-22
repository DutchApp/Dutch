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
    NSData *binJSONData = [DUTUtility dataFromDocument:@"localizedtext_en"];


    if (![binJSONData length]) {
        error = [self createLocalizationFileWithBuiltinLocalization];
    }
    else {
        sLocaleData =
            [NSJSONSerialization JSONObjectWithData:binJSONData options:0 error:&error];
        
        NSString *bundleLocVersion = [self localizationDictFromBundle][@"VERSION"];
        if (bundleLocVersion.integerValue > [self txtVersion].integerValue) {
            //Recreate file with localization in bundle
            error = [self createLocalizationFileWithBuiltinLocalization];
            sLocaleData = [self localizationDictFromBundle];
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
    NSDictionary *dict = [self localizationDictFromBundle];
    NSLog(@"Writing Locale data %@",dict);
    NSData *binJSONData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    [binJSONData writeToDocument:@"localizedtext_en"];
    return error;
}

+ (NSDictionary *)localizationDictFromBundle {
    NSURL *bundleLocalizationFile =
        [[NSBundle mainBundle]URLForResource:@"localizedtext_en" withExtension:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfURL:bundleLocalizationFile];
    return dict;
}
@end
