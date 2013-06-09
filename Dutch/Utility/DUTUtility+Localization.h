//
//  DUTUtility+Localization.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/16/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility.h"


@interface DUTUtility (Localization)

+ (NSString *)localizedStringWithId:(NSString *)stringId;

+ (NSString *)currentLocaleCurrencySymbol;

+ (NSString *)currencySymbolForCurrencyCode:(NSString *)currencyCode;

+ (void)localizationLoad;

@end
