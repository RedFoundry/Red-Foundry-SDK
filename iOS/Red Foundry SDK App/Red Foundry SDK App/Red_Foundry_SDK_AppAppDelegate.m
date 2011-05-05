//
//  Red_Foundry_SDK_AppAppDelegate.m
//  Red Foundry SDK App
//
//  Created by Jim Heising on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Red_Foundry_SDK_AppAppDelegate.h"
#import "RFVIZSDK.h"

@implementation Red_Foundry_SDK_AppAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	[_window makeKeyAndVisible];
	
	[_window addSubview:[RFManager sharedInstance].rootController.view];
	
    BOOL isVIZMode = NO;
    
	// Start our RFManager singleton
	if(isVIZMode)
	{
		[[RFManager sharedInstance] startVIZWithLaunchOptions:launchOptions];
	}
	else
	{
		[[RFManager sharedInstance] startAppWithLaunchOptions:launchOptions];
	}
	
	// Register for push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
	[UIApplication sharedApplication].applicationSupportsShakeToEdit = NO;
	
	return YES;
}

- (BOOL)application:(UIApplication *)app handleOpenURL:(NSURL *)url
{
	[[RFManager sharedInstance] handleAppOpenURL:url];
	return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{	
	[[RFManager sharedInstance] registerRemoteNotificationToken:devToken];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	[[RFManager sharedInstance] processIncomingRemoteNotification:userInfo];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
