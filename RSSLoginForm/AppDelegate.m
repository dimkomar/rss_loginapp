//
//  AppDelegate.m
//  RSSLoginForm
//
//  Created by Dmitriy Komar on 7/1/21.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController *rootViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [window setRootViewController:rootViewController];

    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
