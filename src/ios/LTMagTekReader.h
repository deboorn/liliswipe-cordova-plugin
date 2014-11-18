//
//  LTMagTekReader.h
//  LilitabSDK
//
//  Created by Ken Maskrey on 9/14/12.
//  Copyright (c) 2012 Lilitab, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LTGenericDevice.h"
#import "LTConstants.h"

@interface LTMagTekReader : LTGenericDevice

//@property BOOL doPassRawTrackData;
@property (nonatomic) NSMutableString *trkDataFieldID;

- (void)swipeError:(NSNotification *)notification;


@end

