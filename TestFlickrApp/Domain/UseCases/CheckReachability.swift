//
//  CheckReachability.swift
//  TestFlickrApp
//
//  Created by NishiokaKohei on 2016/12/08.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import SystemConfiguration

class CheckReachability {
    
    // MARK: - デバイスがオンラインかどうかを判定する
    func checkReachability(hostName: String) -> Bool {
        
        let reachability = SCNetworkReachabilityCreateWithName(nil, hostName)!
        var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
        
        //Determines if the given target is reachable using the current network configuration.
        guard SCNetworkReachabilityGetFlags(reachability, &flags) else {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
}