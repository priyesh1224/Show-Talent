//
//  Uploadpdfrequest.swift
//  ShowTalent
//
//  Created by maraekat on 10/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import Alamofire

class Pdfuploadrequest
{
    var sendprogress : ((_ done:Progress) -> Void)?
    
    
    
    func uploadImage(url :NSURL, params : Parameters,filename:String,completion:@escaping completionBlock2)
    {
        let header = configureCurrentSession()
        Alamofire.upload(
            multipartFormData: {
                multipartFormData in

                if let urlString = url as? URL {
                    
                    let pdfData = try! Data(contentsOf: urlString.asURL())
                    var data : Data = pdfData

                    multipartFormData.append(data as Data, withName:"\(filename).pdf", mimeType:"application/pdf")
                    for (key, value) in params {
                        multipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
                    }

                    print("Multi part Content -Type")
                    print(multipartFormData.contentType)
                    print("Multi part FIN ")
                    print("Multi part Content-Length")
                    print(multipartFormData.contentLength)
                    print("Multi part Content-Boundary")
                    print(multipartFormData.boundary)
                }
        },
            to: Constants.K_baseUrl + Constants.imageUploadurl,
            method: .post,
            headers: header,
            encodingCompletion: { encodingResult in

                switch encodingResult {

                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(" responses ")
                        print(response)
                        print("end responses")

                       

                    }
                    upload.uploadProgress(closure: { (progress) in
                                       self.sendprogress!(progress)
                                       print("\(progress) is uploaded")
                                   })
                case .failure(let encodingError):
                    print(encodingError)
                    
                }
        })
    }
    
    
}
