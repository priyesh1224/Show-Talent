
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
    
    
    
    func uploadticket(imagesdata : [UIImage], params : Parameters,extensiontype : [String],completion:@escaping completionBlock4)
          {

              

       let header = configureCurrentSession()
              
              
              Alamofire.upload(multipartFormData:
                  {
                      (multipartFormData) in
                      
                  
                    if imagesdata.count > 0 {
                      if extensiontype[0] == "jpg"
                      {
                      multipartFormData.append(imagesdata[0].jpegData(compressionQuality: 0.4)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
                      }
                      else if extensiontype[0] == "png" {
      
      
                          multipartFormData.append(imagesdata[0].pngData()!, withName: "image", fileName: "file.png", mimeType: "image/png")
                      }
                    }
                      for (key, value) in params
                      {
                          multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                      }
              }, to:Constants.K_baseUrl + Constants.submitticket,method: .post,headers:header)
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
                                      completion("done" , nil)
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
      
    
    
    
    
    
    
    
    
    
    
        func uploadgroupverificationimages(imagesdata : Dictionary<String,Dictionary<String,Any>>,imgsarray : [UIImage], params : Parameters,extensiontype : Dictionary<String,String>,exttype : [String],completion:@escaping completionBlock4)
        {
            
         var url = Constants.K_baseUrl + Constants.postgroupdocuments
            let header = configureCurrentSession()
           
            Alamofire.upload(multipartFormData:
                        {
                            (multipartFormData) in
                            
                            
                            for var k in 0 ..< imgsarray.count {
                                if exttype[k] == "jpg"
                                 {
                                 multipartFormData.append(imgsarray[k].jpegData(compressionQuality: 0.5)!, withName: "documentid_1", fileName: "file.jpg", mimeType: "image/jpg")
                                      multipartFormData.append(("1" as! String).data(using: .utf8)!, withName: "documentid_\(k+1)")
                                 }
                                 else if exttype[k] == "png" {
                                     
                                
                                     multipartFormData.append(imgsarray[k].pngData()!, withName: "documentid_1", fileName: "file.png", mimeType: "image/png")
                                      multipartFormData.append(("1" as! String).data(using: .utf8)!, withName: "documentid_\(k+1)")
                                 }
                            }
                        
                            
                            for (key, value) in params
                            {
                                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                            }
                    }, to:url,method: .post,headers:header)
                    { (result) in
                        print(result)
                        switch result {
                        case .success(let upload,_,_ ):
                            upload.uploadProgress(closure: { (progress) in
//                                self.sendprogress!(progress)
                                print("\(progress) is uploaded")
                            })
                         
                            
                            upload.responseString
                                { response in
                                    print("Response String")
                                    print(response)
                                    print("A")
                                    print(response.result)
                                    print("B")
                                    if let tt = response.result.value {
                                        print(tt)
                                        print(type(of: tt))
                                        if response.result.isSuccess {
                                            completion("done",nil)
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

           func uploadgroupverificationimages1(imagesdata : Dictionary<String,Dictionary<String,Any>>,imgsarray : [UIImage], params : Parameters,extensiontype : Dictionary<String,String>,exttype : [String],completion:@escaping completionBlock4)
           {

     let header = configureCurrentSession()
            
            
            
            var url = Constants.K_baseUrl + Constants.postgroupdocuments
            
            print(url)
            print(header)
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = header
            // disable default credential store
            configuration.urlCredentialStorage = nil

            let manager = Alamofire.SessionManager(configuration: configuration)
            
   


//               Alamofire.upload(multipartFormData: { multipartFormData in
//
////                       for (key, value) in params {
////                        if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
////                               multipartFormData.append(data, withName: key)
////                           }
////                       }
//
//               print(params)
//
//
//                if imgsarray.count == 1 {
//                    if exttype[0] == "jpg" || exttype[0] == "jpeg" {
//                    multipartFormData.append(imgsarray[0].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                    }
//                    else {
//                         multipartFormData.append(imgsarray[0].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
//                    }
//                     multipartFormData.append(("documentid_1" as! String).data(using: .utf8)!, withName: "key")
//                }
//                else if imgsarray.count == 2 {
//                    if exttype[0] == "jpg" || exttype[0] == "jpeg" {
//                    multipartFormData.append(imgsarray[0].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                    }
//                    else {
//                         multipartFormData.append(imgsarray[0].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
//                    }
//                    multipartFormData.append(("documentid_1" as! String).data(using: .utf8)!, withName: "key")
//                    if exttype[1] == "jpg" || exttype[1] == "jpeg" {
//                    multipartFormData.append(imgsarray[1].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                    }
//                    else {
//                         multipartFormData.append(imgsarray[1].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
//                    }
//                    multipartFormData.append(("documentid_2" as! String).data(using: .utf8)!, withName: "key")
//                }
//                else if imgsarray.count == 3 {
//                    if exttype[0] == "jpg" || exttype[0] == "jpeg" {
//                    multipartFormData.append(imgsarray[0].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                    }
//                    else {
//                         multipartFormData.append(imgsarray[0].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
//                    }
//                    multipartFormData.append(("documentid_1" as! String).data(using: .utf8)!, withName: "key")
//                    if exttype[1] == "jpg" || exttype[1] == "jpeg" {
//                    multipartFormData.append(imgsarray[1].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                    }
//                    else {
//                         multipartFormData.append(imgsarray[1].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
//                    }
//                    multipartFormData.append(("documentid_2" as! String).data(using: .utf8)!, withName: "key")
//                    if exttype[2] == "jpg" || exttype[2] == "jpeg" {
//                    multipartFormData.append(imgsarray[2].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//                    }
//                    else {
//                         multipartFormData.append(imgsarray[2].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
//                    }
//                    multipartFormData.append(("documentid_3" as! String).data(using: .utf8)!, withName: "key")
//
//                }
//
//                       for (key,value) in params {
//                                           multipartFormData.append(("\(value)" as! String).data(using: .utf8)!, withName: key)
//                                      }
//
//               },
//                                to: url,method: .post,headers:header){ ( encodingResult) in
//                    print(encodingResult)
//                       switch encodingResult {
//                       case .success(let upload, _, _):
//                           upload
//                               .validate()
//                               .responseJSON { response in
//                                   switch response.result {
//                                   case .success(let value):
//                                       print("responseObject: \(value)")
//                                   case .failure(let responseError):
//                                       print("responseError: \(responseError)")
//                                   }
//                           }
//                       case .failure(let encodingError):
//                           print("encodingError: \(encodingError)")
//                       }
//            }
            
            
            
            
            
            
            
            Alamofire.upload(multipartFormData:
                {
                    (multipartFormData) in

                    print("Images data")
                    print(imagesdata)
                    print("Extension Type")
                    print(extensiontype)
//                    for each in imagesdata {
//                        var val = each.value
//                        var exte = each.key
//                        print("Exte \(exte)")
//                        for t in val  {
//                            if let cap = t.key as? String, let im = t.value as? UIImage {
//
//                                if extensiontype[exte] == "jpg"
//                                                {
//                                                    multipartFormData.append("\(cap)".data(using: String.Encoding.utf8)!, withName: "\(cap)")
//                                                multipartFormData.append(im.jpegData(compressionQuality: 0.1)!, withName: "\(cap)", fileName: "file.jpg", mimeType: "image/jpg")
//                                                }
//                                                else if extensiontype[exte] == "png" {
//                                    multipartFormData.append("\(cap)".data(using: String.Encoding.utf8)!, withName: "\(cap)")
//
//                                                    multipartFormData.append(im.pngData()!, withName: "\(cap)", fileName: "file.png", mimeType: "image/png")
//                                                }
//                                                for (key, value) in params
//                                                {
//                                                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
//                                                }
//                                print("Multi")
//                                print(multipartFormData.self)
//                            }
//
//
//                        }
//                    }
                    
                    
                    if imgsarray.count == 1 {
                                       if exttype[0] == "jpg" || exttype[0] == "jpeg" {
                                       multipartFormData.append(imgsarray[0].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                                       }
                                       else {
                                            multipartFormData.append(imgsarray[0].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
                                       }
                                        multipartFormData.append(("documentid_1" as! String).data(using: .utf8)!, withName: "documentid")
                                   }
                                   else if imgsarray.count == 2 {
                                       if exttype[0] == "jpg" || exttype[0] == "jpeg" {
                                       multipartFormData.append(imgsarray[0].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                                       }
                                       else {
                                            multipartFormData.append(imgsarray[0].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
                                       }
                                       multipartFormData.append(("documentid_1" as! String).data(using: .utf8)!, withName: "documentid")
                                       if exttype[1] == "jpg" || exttype[1] == "jpeg" {
                                       multipartFormData.append(imgsarray[1].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                                       }
                                       else {
                                            multipartFormData.append(imgsarray[1].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
                                       }
                                       multipartFormData.append(("documentid_2" as! String).data(using: .utf8)!, withName: "documentid")
                                   }
                                   else if imgsarray.count == 3 {
                                       if exttype[0] == "jpg" || exttype[0] == "jpeg" {
                                       multipartFormData.append(imgsarray[0].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                                       }
                                       else {
                                            multipartFormData.append(imgsarray[0].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
                                       }
                                       multipartFormData.append(("documentid_1" as! String).data(using: .utf8)!, withName: "documentid")
                                       if exttype[1] == "jpg" || exttype[1] == "jpeg" {
                                       multipartFormData.append(imgsarray[1].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                                       }
                                       else {
                                            multipartFormData.append(imgsarray[1].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
                                       }
                                       multipartFormData.append(("documentid_2" as! String).data(using: .utf8)!, withName: "documentid")
                                       if exttype[2] == "jpg" || exttype[2] == "jpeg" {
                                       multipartFormData.append(imgsarray[2].jpegData(compressionQuality: 0.5)!, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                                       }
                                       else {
                                            multipartFormData.append(imgsarray[2].pngData()!, withName: "file", fileName: "image.png", mimeType: "image/png")
                                       }
                                       multipartFormData.append(("documentid_3" as! String).data(using: .utf8)!, withName: "documentid")
                        
                                    multipartFormData.append(("1097").data(using: .utf8)!, withName: "groupId")
                        
                                       
                                   }
                                          
//                                          for (key,value) in params {
//                                                              multipartFormData.append(("\(value)" as! String).data(using: .utf8)!, withName: key)
//                                                         }
                    
                    
                    
                    
                    
            }, to:Constants.K_baseUrl + Constants.postgroupdocuments,method: .post,headers:header)
            { (result) in
                 print(result)
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
                        print("Check this")
                        print(response.result.isSuccess)
                        if response.result.isSuccess {
                            var jsondata = response.result.value as? NSDictionary
                            var x = NSDictionary(object: "done", forKey: "status" as NSCopying)
                            completion(x , nil)
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
