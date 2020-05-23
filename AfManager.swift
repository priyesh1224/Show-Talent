//
//  AfManager.swift
//  ShowTalent
//
//  Created by apple on 9/11/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import Alamofire





typealias completionBlock = (_ response: DataResponse<Any>?, _ err : Error?) -> Void
typealias completionBlock2 = (_ response: NSDictionary?, _ err : Error?) -> Void
typealias completionBlock3 = (_ response: Bool?, _ err : Error?) -> Void
typealias completionBlock4 = (_ response: String?, _ err : Error?) -> Void

class BaseServiceClass: NSObject {
    
    func getApiRequest(url:String, parameters:Dictionary<String , Any>, completion:@escaping completionBlock) {
        let headers = configureCurrentSession()
        Alamofire.request(url,method: .get,parameters: parameters, encoding : URLEncoding.default ,headers:headers).responseJSON { sessionData in
            switch sessionData.result {
            case .success:

            completion(sessionData, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
        }
    }
    }
    func postApiRequest(url:String, parameters:Dictionary<String , Any>,completion:@escaping completionBlock) {
        let headers = configureCurrentSession()
        Alamofire.request(url,method: .post,parameters: parameters, encoding : JSONEncoding.default, headers: headers).responseJSON { (sessionData) in
            
            
            
            
            switch sessionData.result {
                
            case .success:
                completion(sessionData, nil)
                
//                Ref_guid" = "034db6d3-e488-49b7-8c65-3a722e6372b9";
//                profileStatus = 0;
//                token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjaGFuZGFuQG1hcmFla2F0LmNvbSIsImp0aSI6IjE1Nzc2N2RmLWUxZmQtNGQ2Yi04NTA5LWJhNTQ4ZmVhODRmMiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMDM0ZGI2ZDMtZTQ4OC00OWI3LThjNjUtM2E3MjJlNjM3MmI5IiwiZXhwIjoxNTcwODc1MTUzLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9.ul5HfKjYc_6NJBwoefvwMeclTlFrcqxMbSkKfziAC0I"
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
            
//            case .
//            completion(sessionData ,nil)
        }
    }
    
    
 
        
    
      
    
    
    func custompostApiRequest(url:String, parameters:Dictionary<String , Any>,completion:@escaping completionBlock) {
            let headers = customConfigureCurrentSession()
      
        Alamofire.request(url,method: .post,parameters: parameters, encoding : JSONEncoding.default , headers: headers).responseJSON { (sessionData) in
                
                
                
                
                switch sessionData.result {
                    
                case .success:
                    completion(sessionData, nil)
                    
    //                Ref_guid" = "034db6d3-e488-49b7-8c65-3a722e6372b9";
    //                profileStatus = 0;
    //                token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjaGFuZGFuQG1hcmFla2F0LmNvbSIsImp0aSI6IjE1Nzc2N2RmLWUxZmQtNGQ2Yi04NTA5LWJhNTQ4ZmVhODRmMiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMDM0ZGI2ZDMtZTQ4OC00OWI3LThjNjUtM2E3MjJlNjM3MmI5IiwiZXhwIjoxNTcwODc1MTUzLCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9.ul5HfKjYc_6NJBwoefvwMeclTlFrcqxMbSkKfziAC0I"
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
                
    //            case .
    //            completion(sessionData ,nil)
            }
        }
    func configureCurrentSession() -> HTTPHeaders {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20800
        manager.session.configuration.timeoutIntervalForResource = 20800
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        
        // add your custom header
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        print("Token is \(UserDefaults.standard.value(forKey: "token") as? String )")
        if let t = UserDefaults.standard.value(forKey: "token") as? String {
            headers["Authorization"] = "Bearer \(t)"
            print(t)
        }
//        if (UserDefaults.standard.value(forKey: "noauth") as? Bool == false)
//        {
//        let usertoekn = UserDefaults.standard.value(forKey: "token")!
////            let usertoekn = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6IjY1ZDc0Mjg1LTc5NWMtNDc1ZS1iMDM5LTlhNDdiODA3OTVkNSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzQ5MTU4LCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9.0FUPvMFAjWx_s5BklGELxSQz_iiCCaaXSjh0GEejVwY"
//        if(usertoekn != nil) {
//            headers["Authorization"] = "Bearer \(usertoekn)"
//            print("Bearer \(usertoekn)")
//        }
//        }
        return headers
    }
    
    func customConfigureCurrentSession() -> HTTPHeaders {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 20800
            manager.session.configuration.timeoutIntervalForResource = 20800
            var headers = Alamofire.SessionManager.defaultHTTPHeaders
            
            // add your custom header
//            headers["Accept"] = "application/json"
//            headers["Content-Type"] = "application/x-www-form-urlencoded"
            if (UserDefaults.standard.value(forKey: "noauth") as? Bool == false)
            {
            let usertoekn = UserDefaults.standard.value(forKey: "token")!
    //            let usertoekn = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdmFzYW5pMTg3QGdtYWlsLmNvbSIsImp0aSI6IjY1ZDc0Mjg1LTc5NWMtNDc1ZS1iMDM5LTlhNDdiODA3OTVkNSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiZjA3NGEwZTQtODE0My00NDJmLTk4OTYtZTQ1ZDg1ZDQyMjJmIiwiZXhwIjoxNTgyMzQ5MTU4LCJpc3MiOiJodHRwOi8vZXRlY2htaWwuY29tIiwiYXVkIjoiaHR0cDovL2V0ZWNobWlsLmNvbSJ9.0FUPvMFAjWx_s5BklGELxSQz_iiCCaaXSjh0GEejVwY"
            if(usertoekn != nil) {
                headers["Authorization"] = "Bearer \(usertoekn)"
                print("Bearer \(usertoekn)")
            }
            }
            return headers
        }
}


//class func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//    
//    Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
//        
//        print(responseObject)
//        
//        if responseObject.result.isSuccess {
//            let resJson = JSON(responseObject.result.value!)
//            success(resJson)
//        }
//        if responseObject.result.isFailure {
//            let error : Error = responseObject.result.error!
//            failure(error)
//        }
//    }
//}
//}
