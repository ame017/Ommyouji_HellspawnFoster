//
//  AMELocation.m
//  AMEFilm
//
//  Created by syetc053 on 16/7/25.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMELocation.h"
@interface AMELocation ()<CLLocationManagerDelegate>
{
    CLGeocoder * _coder;
    CLLocationManager * _locationManager;
}
@property (copy) void (^completion) (CLLocationDegrees latitude,CLLocationDegrees longitude,NSString * locationString);
@end

@implementation AMELocation
#pragma mark 定位

AMELocation * _location;

+ (instancetype)sharedLocation{
    @synchronized(self) {
        if (!_location) {
            _location = [AMELocation new];
        }
    }
    return _location;
}

- (void)getLocationWithCompletion:(void (^)(CLLocationDegrees latitude,CLLocationDegrees longitude,NSString * locationString))completion{
    
    self.completion = completion;
    
    _coder = [CLGeocoder new];
    _locationManager = [CLLocationManager new];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"没有打开定位");
        return ;
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
        NSLog(@"request");
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10.0;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocationCoordinate2D coordinate = [locations firstObject].coordinate;
    NSLog(@"经度%lf,纬度%lf",coordinate.longitude,coordinate.latitude);
    [manager stopUpdatingLocation];
    self.latitude = coordinate.latitude;
    self.longitude = coordinate.longitude;
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    [_locationManager stopUpdatingLocation];
}
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    NSLog(@"%@",location);
    [_coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
//        NSLog(@"详细信息:%@",placemark.addressDictionary);
//        NSLog(@"city=%@",placemark.addressDictionary[@"City"]);
        self.locationString = placemark.addressDictionary[@"City"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getLocation" object:nil userInfo:nil];
        self.completion(latitude,longitude,self.locationString);
    }];
}
@end
