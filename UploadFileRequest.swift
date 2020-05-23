
import Foundation
import Alamofire
//
class ImageUploadRequest {
    var sendprogress : ((_ done:Progress) -> Void)?
    var sendprogress2 : ((_ done:Progress) -> ())?

    func uploadImage(imagesdata : [UIImage], params : Parameters,url : String,extensiontype : [String],completion:@escaping completionBlock2)
    {

        

 let header = configureCurrentSession()
        
        
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                
            
                if extensiontype[0] == "jpg"
                {
                multipartFormData.append(imagesdata[0].jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
                }
                else if extensiontype[0] == "png" {


                    multipartFormData.append(imagesdata[0].pngData()!, withName: "image", fileName: "file.png", mimeType: "image/png")
                }
                for (key, value) in params
                {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
        }, to:url,method: .post,headers:header)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    if let p = progress as? Progress {
                        self.sendprogress!(progress)
                    }
                    
                    print("\(progress) is uploaded")
                })
             
                
                upload.responseString
                    { response in
                        print("Response String")
                        print(response)
                        print(response.result)
                        
                        print(response.result.value)
                            if response.result.isSuccess {
                            var jsondata = response.result.value as? NSDictionary
                            
                             completion(jsondata , nil)
//                                if response.result == "SUCCESS:"
//                                {
//                                  print("DATA UPLOAD SUCCESSFULLY")
//                                }
                            
                        }
                    }
            case .failure(let encodingError):
                completion(nil , encodingError)
                break
                
            }
        }
        
        
        
        
        
        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            // import image to request
//            for imageData in imagesdata {
//                let imagesd = imageData.jpegData(compressionQuality: 0.6)
//                print(imagesd)
//                //if  let imaged = UIImageJPEGRepresentation(imageData, 1) {
//                multipartFormData.append(imagesd!, withName: "imagess", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//                print(multipartFormData)
//            }
//            for (key, value) in params {
//                
//                if value is String || value is Int {
//                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//                }
//                
//                
//            //    multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8)!, withName: key)
//            }
//           
//        }, to: Constants.K_baseUrl + Constants.imageUploadurl, method: .post , headers: header,
//
//           encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//               
//                upload.responseJSON { response in
//                    completion(response , nil)
//
//                }
//                upload.uploadProgress { (pro) in
//                    
//                    self.sendprogress!(pro)
//                    print("\(pro) is uploaded")
//                }
//            case .failure(let error):
//                print(error)
//                
//                completion(nil , error)
//            }
//
//        })
    }
    
    

        func uploadnewgrouppost(imagesdata : [UIImage], params : Parameters,extensiontype : [String],completion:@escaping completionBlock3)
        {

            

     let header = configureCurrentSession()
            
            
            Alamofire.upload(multipartFormData:
                {
                    (multipartFormData) in
                    
                
    
                    for (key, value) in params
                    {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
            }, to:Constants.K_baseUrl + Constants.grouppost,method: .post,headers:header)
            { (result) in
                switch result {
                case .success(let upload,_,_ ):
                    upload.uploadProgress(closure: { (progress) in
                        print("\(progress) is uploaded")
                    })
                 
                    
                    upload.responseString
                        { response in
                            print("Response String")
                            print(response)
                            print(response.result)
                            
                            print(response.result.value)
                            if response.result.isSuccess {
                                completion(true,nil)
                            }
                            else {
                                completion(false,nil)
                            }
                        }
                case .failure(let encodingError):
                    completion(nil , encodingError)
                    break
                    
                }
            }
    }
    
    
        func uploadnewgrouppostimages(imagesdata : [UIImage], params : Parameters,extensiontype : [String],completion:@escaping completionBlock4)
        {

            

     let header = configureCurrentSession()
            
            
            Alamofire.upload(multipartFormData:
                {
                    (multipartFormData) in
                    
                
                    if extensiontype[0] == "jpg"
                    {
                    multipartFormData.append(imagesdata[0].jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
                    }
                    else if extensiontype[0] == "png" {
    
    
                        multipartFormData.append(imagesdata[0].pngData()!, withName: "image", fileName: "file.png", mimeType: "image/png")
                    }
                    for (key, value) in params
                    {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
            }, to:Constants.K_baseUrl + Constants.grouppost,method: .post,headers:header)
            { (result) in
                switch result {
                case .success(let upload,_,_ ):
                    upload.uploadProgress(closure: { (progress) in
                        
                        
                        print("\(progress) is uploaded")
                    })
                 
                    
                    upload.responseString
                        { response in
                            print("Response String")
                            print(response)
                            print(response.result)
                            
                            print(response.result.value)
                                if response.result.isSuccess {
                                var jsondata = response.result.value as? NSDictionary
                                
                                    if response.result.isSuccess {
                                    completion("SUCCESS" , nil)
                                    }
                                    else{
                                         completion(nil , nil)
                                    }
    //                                if response.result == "SUCCESS:"
    //                                {
    //                                  print("DATA UPLOAD SUCCESSFULLY")
    //                                }
                                
                            }
                        }
                case .failure(let encodingError):
                    completion(nil , encodingError)
                    break
                    
                }
            }
    }
    
    
        func uploadgroupIcon(imagesdata : [UIImage], params : Parameters,extensiontype : [String],completion:@escaping completionBlock2)
        {
            
            print("Going to upload image for ")
            print(params)

            

     let header = configureCurrentSession()
            
            
            Alamofire.upload(multipartFormData:
                {
                    (multipartFormData) in
                    
                
                    if extensiontype[0] == "jpg"
                    {
                    multipartFormData.append(imagesdata[0].jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
                    }
                    else if extensiontype[0] == "png" {
                        
                   
                        multipartFormData.append(imagesdata[0].pngData()!, withName: "image", fileName: "file.png", mimeType: "image/png")
                    }
                    for (key, value) in params
                    {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
            }, to:Constants.K_baseUrl + Constants.updategroupicon,method: .post,headers:header)
            { (result) in
                switch result {
                case .success(let upload,_,_ ):
                    upload.uploadProgress(closure: { (progress) in
                        self.sendprogress!(progress)
                        print("\(progress) is uploaded")
                    })
                 
                    
                    upload.responseString
                        { response in
                            print("Response String")
                            print(response)
                            print(response.result)
                            
                            print(response.result.value)
                                if response.result.isSuccess {
                                var jsondata = response.result.value as? NSDictionary
                                
                                 completion(jsondata , nil)
    //                                if response.result == "SUCCESS:"
    //                                {
    //                                  print("DATA UPLOAD SUCCESSFULLY")
    //                                }
                                
                            }
                        }
                case .failure(let encodingError):
                    completion(nil , encodingError)
                    break
                    
                }
            }
            
            
            
            
            
            
    //        Alamofire.upload(multipartFormData: { multipartFormData in
    //            // import image to request
    //            for imageData in imagesdata {
    //                let imagesd = imageData.jpegData(compressionQuality: 0.6)
    //                print(imagesd)
    //                //if  let imaged = UIImageJPEGRepresentation(imageData, 1) {
    //                multipartFormData.append(imagesd!, withName: "imagess", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
    //                print(multipartFormData)
    //            }
    //            for (key, value) in params {
    //
    //                if value is String || value is Int {
    //                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
    //                }
    //
    //
    //            //    multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8)!, withName: key)
    //            }
    //
    //        }, to: Constants.K_baseUrl + Constants.imageUploadurl, method: .post , headers: header,
    //
    //           encodingCompletion: { encodingResult in
    //            switch encodingResult {
    //            case .success(let upload, _, _):
    //
    //                upload.responseJSON { response in
    //                    completion(response , nil)
    //
    //                }
    //                upload.uploadProgress { (pro) in
    //
    //                    self.sendprogress!(pro)
    //                    print("\(pro) is uploaded")
    //                }
    //            case .failure(let error):
    //                print(error)
    //
    //                completion(nil , error)
    //            }
    //
    //        })
        }
    
    
    
    
    
    
    func uploadgroupIcontry(imagesdata : [UIImage], params : Parameters,extensiontype : [String],completion:@escaping completionBlock2)
    {
        
        print("Going to upload image for ")
        print(params)
        
        
        
        let header = configureCurrentSession()
        
        
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                
                
                if extensiontype[0] == "jpg"
                {
                    multipartFormData.append(imagesdata[0].jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
                }
                else if extensiontype[0] == "png" {
                    
                    
                    multipartFormData.append(imagesdata[0].pngData()!, withName: "image", fileName: "file.png", mimeType: "image/png")
                }
                for (key, value) in params
                {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
        }, to:Constants.K_baseUrl + Constants.participatepost,method: .post,headers:header)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    self.sendprogress!(progress)
                    print("\(progress) is uploaded")
                })
                
                
                upload.responseString
                    { response in
                        print("Response String")
                        print(response)
                        print(response.result)
                        
                        print(response.result.value)
                        if response.result.isSuccess {
                            var jsondata = response.result.value as? NSDictionary
                            
                            completion(jsondata , nil)
                            //                                if response.result == "SUCCESS:"
                            //                                {
                            //                                  print("DATA UPLOAD SUCCESSFULLY")
                            //                                }
                            
                        }
                }
            case .failure(let encodingError):
                completion(nil , encodingError)
                break
                
            }
        }
        
        
        
        
        
        
        //        Alamofire.upload(multipartFormData: { multipartFormData in
        //            // import image to request
        //            for imageData in imagesdata {
        //                let imagesd = imageData.jpegData(compressionQuality: 0.6)
        //                print(imagesd)
        //                //if  let imaged = UIImageJPEGRepresentation(imageData, 1) {
        //                multipartFormData.append(imagesd!, withName: "imagess", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
        //                print(multipartFormData)
        //            }
        //            for (key, value) in params {
        //
        //                if value is String || value is Int {
        //                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
        //                }
        //
        //
        //            //    multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8)!, withName: key)
        //            }
        //
        //        }, to: Constants.K_baseUrl + Constants.imageUploadurl, method: .post , headers: header,
        //
        //           encodingCompletion: { encodingResult in
        //            switch encodingResult {
        //            case .success(let upload, _, _):
        //
        //                upload.responseJSON { response in
        //                    completion(response , nil)
        //
        //                }
        //                upload.uploadProgress { (pro) in
        //
        //                    self.sendprogress!(pro)
        //                    print("\(pro) is uploaded")
        //                }
        //            case .failure(let error):
        //                print(error)
        //
        //                completion(nil , error)
        //            }
        //
        //        })
    }

    
    
    
        func uploadImageprofilepicture(imagesdata : [UIImage], params : Parameters,extensiontype : [String],completion:@escaping completionBlock2)
        {

            

     let header = configureCurrentSession()
            
            
            Alamofire.upload(multipartFormData:
                {
                    (multipartFormData) in
                    
                
                    if extensiontype[0] == "jpg"
                    {
                    multipartFormData.append(imagesdata[0].jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
                    }
                    else if extensiontype[0] == "png" {
                        
                   
                        multipartFormData.append(imagesdata[0].pngData()!, withName: "image", fileName: "file.png", mimeType: "image/png")
                    }
                    for (key, value) in params
                    {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
            }, to:Constants.K_baseUrl + Constants.uploadprofileimage,method: .post,headers:header)
            { (result) in
                switch result {
                case .success(let upload,_,_ ):
                    upload.uploadProgress(closure: { (progress) in
                        print("\(progress) is uploaded")
                    })
                 
                    
                    upload.responseString
                        { response in
                            print("Response String")
                            print(response)
                            print(response.result)
                            
                            print(response.result.value)
                                if response.result.isSuccess {
                                var jsondata = response.result.value as? NSDictionary
                                
                                 completion(jsondata , nil)
    //                                if response.result == "SUCCESS:"
    //                                {
    //                                  print("DATA UPLOAD SUCCESSFULLY")
    //                                }
                                
                            }
                        }
                case .failure(let encodingError):
                    completion(nil , encodingError)
                    break
                    
                }
            }
            
            
            
            
            
            
    //        Alamofire.upload(multipartFormData: { multipartFormData in
    //            // import image to request
    //            for imageData in imagesdata {
    //                let imagesd = imageData.jpegData(compressionQuality: 0.6)
    //                print(imagesd)
    //                //if  let imaged = UIImageJPEGRepresentation(imageData, 1) {
    //                multipartFormData.append(imagesd!, withName: "imagess", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
    //                print(multipartFormData)
    //            }
    //            for (key, value) in params {
    //
    //                if value is String || value is Int {
    //                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
    //                }
    //
    //
    //            //    multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8)!, withName: key)
    //            }
    //
    //        }, to: Constants.K_baseUrl + Constants.imageUploadurl, method: .post , headers: header,
    //
    //           encodingCompletion: { encodingResult in
    //            switch encodingResult {
    //            case .success(let upload, _, _):
    //
    //                upload.responseJSON { response in
    //                    completion(response , nil)
    //
    //                }
    //                upload.uploadProgress { (pro) in
    //
    //                    self.sendprogress!(pro)
    //                    print("\(pro) is uploaded")
    //                }
    //            case .failure(let error):
    //                print(error)
    //
    //                completion(nil , error)
    //            }
    //
    //        })
        }


}
func configureCurrentSession() -> HTTPHeaders {
    let manager = Alamofire.SessionManager.default
//    manager.session.configuration.timeoutIntervalForRequest = 20800
  //  manager.session.configuration.timeoutIntervalForResource = 20800
    var headers = Alamofire.SessionManager.defaultHTTPHeaders
    
    // add your custom header
    headers["Accept"] = "application/json"
    headers["Content-Type"] = "application/json"
//    if (UserDefaults.standard.value(forKey: "noauth") as? Bool == false)
//    {
        let usertoekn = UserDefaults.standard.value(forKey: "token")
        if(usertoekn != nil) {
            headers["Authorization"] = "Bearer \(usertoekn!)"
        }
//    }
    return headers
}
