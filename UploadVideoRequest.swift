//
//  UploadVideoRequest.swift
//  ShowTalent
//
//  Created by apple on 11/6/19.
//  Copyright © 2019 apple. All rights reserved.
//


import Foundation
import Alamofire
//

class Networking {
  static let sharedInstance = Networking()
  public var sessionManager: Alamofire.SessionManager
  public var backgroundSessionManager: Alamofire.SessionManager
  private init() {
    self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    self.backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.showtalent2.app.backgroundtransfer"))
  }
}

class VideoUploadRequest {
    
     var progress = 0.0
    
    var sendprogress : ((_ done:Progress) -> Void)?
    
    
    
    
    func upload(videoURL: URL, success: (() -> Void)?, failure: ((Error) -> Void)?,params : Parameters,completion:@escaping completionBlock) {
    
            var desturl = Constants.K_baseUrl + Constants.imageUploadurl
        
        var headers = configureCurrentSession1()
    Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartData) in
        
        for (key, value) in params {
            
            if value is String || value is Int {
                multipartData.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }
  
    }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: desturl, method: .post, headers: headers, encodingCompletion: { encodingResult in

      switch (encodingResult) {
        
        case .success(let request, let streamingFromDisk, let streamFileURL):
                
                
                request.uploadProgress(closure: { (progress) in
                    self.sendprogress!(progress)
       
                })
        

                request.responseJSON(completionHandler: { response in
                    switch response.result {
                      case .success(let jsonData):
                        completion(response , nil)
                        
                      case .failure(let error):
                        failure?(error)
                    }
                })
        
        case .failure(let error):
          failure?(error)
        
      }
    })
    
    }
    
    
    
    func uploadgrouppostvideo(imagesdata : NSData?, params : Parameters,completion:@escaping completionBlock4)
    {
        
        
        let header = configureCurrentSession1()
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
           // for imageData in imagesdata! {
             //   let imagesd = imageData.jpegData(compressionQuality: 0.6)
                //if  let imaged = UIImageJPEGRepresentation(imageData, 1) {
                multipartFormData.append(imagesdata! as Data, withName: "moviess", fileName: "\(Date().timeIntervalSince1970).mov", mimeType: "video/mov")
                
         //   }
            for (key, value) in params {
                
                if value is String || value is Int {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                
                
                //    multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: Constants.K_baseUrl + Constants.grouppost, method: .post , headers: header,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.result.isSuccess {
                        completion("SUCCESS" , nil)
                    }
                    else {
                        completion(nil,nil)
                    }
                    
                }
                upload.uploadProgress { (pro) in
                    self.sendprogress!(pro)
                    print("\(pro) is uploaded")
                }
                
            case .failure(let error):
                print(error)
                
                completion(nil , error)
            }
            
        })
    }
    
    func uploadAudio(imagesdata : NSData?, params : Parameters,url : String,completion:@escaping completionBlock)
    {
        
        
        let header = configureCurrentSession1()
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            // for imageData in imagesdata! {
            //   let imagesd = imageData.jpegData(compressionQuality: 0.6)
            //if  let imaged = UIImageJPEGRepresentation(imageData, 1) {
            multipartFormData.append(imagesdata! as Data, withName: "audio", fileName: "\(Date().timeIntervalSince1970).m4a", mimeType: "audio/m4a")
            
            //   }
            for (key, value) in params {
                
                if value is String || value is Int {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                
                
                //    multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: url, method: .post , headers: header,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    completion(response , nil)
                    
                }
                upload.uploadProgress { (pro) in
                    
                    self.sendprogress!(pro)
                    print("\(pro) is uploaded")
                }
                
            case .failure(let error):
                print(error)
                
                completion(nil , error)
            }
            
        })
    }
    
    

    
    
    
    
    func uploadVideo(imagesdata : NSData?, params : Parameters,url : String,completion:@escaping completionBlock)
    {
        
        
        let header = configureCurrentSession1()
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
           // for imageData in imagesdata! {
             //   let imagesd = imageData.jpegData(compressionQuality: 0.6)
                //if  let imaged = UIImageJPEGRepresentation(imageData, 1) {
                multipartFormData.append(imagesdata! as Data, withName: "moviess", fileName: "\(Date().timeIntervalSince1970).mov", mimeType: "video/mov")
                
         //   }
            for (key, value) in params {
                
                if value is String || value is Int {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                
                
                //    multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: url, method: .post , headers: header,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    completion(response , nil)
                    
                }
                upload.uploadProgress { (pro) in
                    
                    self.sendprogress!(pro)
                    print("\(pro) is uploaded")
                }
                
            case .failure(let error):
                print(error)
                
                completion(nil , error)
            }
            
        })
    }
    
    
}
func configureCurrentSession1() -> HTTPHeaders {
    let manager = Alamofire.SessionManager.self
    let backgroundmanager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.showtalent2.app.backgroundtransfer"))
    //    manager.session.configuration.timeoutIntervalForRequest = 20800
    //  manager.session.configuration.timeoutIntervalForResource = 20800
    var headers = Alamofire.SessionManager.defaultHTTPHeaders
    
    // add your custom header
    headers["Accept"] = "application/json"
    headers["Content-Type"] = "application/json"
//    if (UserDefaults.standard.value(forKey: "noauth") as? Bool == false)
//    {
    if let usertoekn = UserDefaults.standard.value(forKey: "token") as? String {
        if(usertoekn != nil) {
            headers["Authorization"] = "Bearer \(usertoekn)"
        }
    }
//    }
    print(headers)
    return headers
}

