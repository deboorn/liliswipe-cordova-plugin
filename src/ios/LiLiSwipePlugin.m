#import "LiLiSwipePlugin.h"
#import <Cordova/CDV.h>
#import "LTMagTekReader.h"

@interface LiLiSwipePlugin ()

@property (strong, nonatomic) LTMagTekReader *cardReader;

@end

@implementation LiLiSwipePlugin

@synthesize cardReader = _cardReader;

int opendev=0;

- (void)pluginInitialize;
{
    NSLog(@"In LiLiSwipePlugin Init");
    _cardReader = [[LTMagTekReader alloc] initWithDelegate:self andProtocolString:@"com.lilitab.p1"];
    [super pluginInitialize];
}

- (void)accessoryWasConnected:(EAAccessory *)accessory {
    NSLog(@"LiLiSwipe Connected");
    NSLog(@"Reader was connected %@", accessory);
    opendev=1;
    if(listenerCommand){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Connected"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:listenerCommand.callbackId];
    }
    
}

- (void)accessoryWasDisconnected {
    NSLog(@"LiLiSwipe Disconnected");
    opendev=0;
    if(listenerCommand){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Disconnected"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:listenerCommand.callbackId];
    }
}

- (void)accessoryDidPassRawData:(NSString *)rawData
{
    NSLog(@"LiLiSwipe Accessory Data (RawDat) Notification Received");
}

- (void) accessoryDidPassRawDataOnly:(NSString *)rawData    {
    NSLog(@"LiLiSwipe Accessory Data (RawDataOnly) Notification Received");
    
    NSRange t1StartSentinel = [rawData  rangeOfString:@"%"];    // Find T1 Start Sentinel
    NSMutableString *firstHalf = [NSMutableString stringWithString:[rawData  substringFromIndex:t1StartSentinel.location]];
    NSRange t1EndSentinel = [firstHalf rangeOfString:@"?"];
    firstHalf = [NSMutableString stringWithString:[firstHalf  substringToIndex:t1EndSentinel.location+1]];
//    NSLog(@"****accessoryDidPassRawDataOnly: T1= %@",[firstHalf substringToIndex:t1EndSentinel.location+1]);
    
    if(listenerCommand){
        NSLog(@"%@", listenerCommand.callbackId);
        NSLog(@"Sending plugin data notification");
        NSString *response = [NSString stringWithString:[firstHalf substringToIndex:t1EndSentinel.location+1]];
//        NSLog(@"Sending response:%@", response);
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:response];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:listenerCommand.callbackId];
    }
}


- (BOOL) isConnected
{
    return opendev;
}

- (void)isConnected:(CDVInvokedUrlCommand *)command
{
    NSLog(@"isConnected");
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[self isConnected]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)registerListener:(CDVInvokedUrlCommand*)command
{
    NSLog(@"Registering Cordova JS Listener");
    listenerCommand = command;
}


@end