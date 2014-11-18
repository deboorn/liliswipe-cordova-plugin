#import <Cordova/CDV.h>
#import	<ExternalAccessory/ExternalAccessory.h>
#import "iMag.h"

@interface LiLiSwipePlugin : CDVPlugin
{
    iMag *iReader;
    CDVInvokedUrlCommand *listenerCommand;
}

- (BOOL) isConnected;

- (void)isConnected:(CDVInvokedUrlCommand*)command;

- (void)registerListener:(CDVInvokedUrlCommand*)command;


@end