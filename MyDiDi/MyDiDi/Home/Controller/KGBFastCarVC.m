//
//  KGBFastCarVC.m
//  MyDiDi
//
//  Created by 邝贵斌 on 17/4/23.
//  Copyright © 2017年 kuangguibin. All rights reserved.
//

#import "KGBFastCarVC.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
@interface KGBFastCarVC ()<BMKPoiSearchDelegate,BMKMapViewDelegate>

@property(nonatomic,strong) BMKMapView* mapView;
@property(nonatomic,strong) BMKPoiSearch*  PoiSearch;

@end

@implementation KGBFastCarVC

//地图视图
-(BMKMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[BMKMapView alloc] init];
        
    }
    return _mapView;
}

//检索对象
-(BMKPoiSearch *)PoiSearch{
    if (_PoiSearch == nil) {
        //初始化检索对象
        _PoiSearch =[[BMKPoiSearch alloc]init];
        _PoiSearch.delegate = self;
    }
    return _PoiSearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.mapView;
    self.mapView.frame = [UIScreen  mainScreen].bounds;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.PoiSearch.delegate = nil;
}

//-(void)viewDidLayoutSubviews{
//    [super  viewDidLayoutSubviews];
//    self.mapView.frame = self.view.bounds;
//    NSLog(@"------%@",self.mapView);
//}


#pragma mark ----------------------------------------------
#pragma mark ---检索

/**
 长按地图的时间调用
 
 @param mapView 地图地图
 @param coordinate 点击的经纬度
 */
-(void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate{
    
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0; //检索页
    option.pageCapacity = 10; // 检索多少个
    option.location = coordinate; //从这个经纬度开始周边检索
    option.keyword = @"小吃";  //检索关键字
    BOOL flag = [self.PoiSearch poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
    
    //自动放大地图
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.013142, 0.011678);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coordinate, span);
    [self.mapView  setRegion:(region) animated:YES];
}


#pragma mark ----------------------------------------------
#pragma mark ---大头针
/**
 检索到结果调用
 
 @param searcher 检索对象
 @param poiResultList 检索到的结果
 @param error 错误信息
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSArray*poiArr = poiResultList.poiInfoList;
        //遍历检索结果数组
        for (BMKPoiInfo*poiInfo in poiArr) {
            // 添加大头针
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = poiInfo.pt;
            annotation.title = poiInfo.name;
            annotation.subtitle = poiInfo.address;
            [self.mapView addAnnotation:annotation];
        }
        
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}



/**
 当添加一个大头针数据模型的时候,会来到该方法,创建对应的大头针视图并返回
 
 @param mapView 地图视图
 @param annotation 大头针数据模型
 @return 大头针视图
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        static NSString* ID = @"myAnnotation";
        //大头针重用机制
        BMKPinAnnotationView* newAnnotationView = (BMKPinAnnotationView*)[mapView  dequeueReusableAnnotationViewWithIdentifier:ID];
        if (newAnnotationView ==nil) {
            newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
            //设置大头针颜色
            newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
            newAnnotationView.animatesDrop = YES;// 设置大头针下落动画
            
        }
        return newAnnotationView;
    }
    return nil;
}




@end
