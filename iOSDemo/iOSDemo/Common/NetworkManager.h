//
//  NetworkManager.h
//  iOSDemo
//
//  Created by Uroosa on 07/22/22.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

- (NSString *) getDataFrom:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
