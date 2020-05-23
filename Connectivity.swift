//
//  Connectivity.swift
//  ShowTalent
//
//  Created by apple on 10/18/19.
//  Copyright © 2019 apple. All rights reserved.
//


import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
