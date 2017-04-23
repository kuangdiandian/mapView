

#import "AppDelegate.h"
#import "KGBNavigationController.h"
#import "KGBHomeVC.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface AppDelegate ()<BMKGeneralDelegate>

@property(nonatomic,strong) BMKMapManager* mapManager;
@end

@implementation AppDelegate


// 要使用百度地图，请先启动BaiduMapManager
-(BMKMapManager *)mapManager{
    if (_mapManager == nil) {
        _mapManager = [[BMKMapManager alloc]init];
    }
    return _mapManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow  alloc] initWithFrame:[UIScreen  mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [self.mapManager start:@"glxprTjuaStqVPUzqeFMcYmOFx3LGIoG"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    KGBHomeVC* homeVC = [[KGBHomeVC  alloc] init];
    KGBNavigationController*naVC = [[KGBNavigationController  alloc]  initWithRootViewController:homeVC];
    self.window.rootViewController = naVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark ----------------------------------------------
#pragma mark ---代理方法

/**
 监听网络验证
 
 @param iError 错误信息
 */
-(void)onGetNetworkState:(int)iError{
    if (0 == iError) {
        NSLog(@"网络验证通过");
    } else{
        NSLog(@"网络验证失败");
    }
}

/**
 监听授权验证
 
 @param iError 错误信息
 */
-(void)onGetPermissionState:(int)iError{
    if (0 == iError) {
        NSLog(@"授权验证通过");
    } else{
        NSLog(@"授权验证失败");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
