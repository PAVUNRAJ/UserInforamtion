//
//  ConstantFile.swift
//  Shoppee
//
//  Created by Tech on 3/14/22.
//


import UIKit
import Alamofire

class WebService: NSObject {
    
//    var spinner = UIActivityIndicatorView(style: .UIActivityIndicatorView.Style.large)
    func callAPI(url : String, method: String, post: NSDictionary, completionHandler:@escaping(Data) -> ()) {
   
        let encodeURL : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        DispatchQueue.main.async {
//            self.spinner.translatesAutoresizingMaskIntoConstraints = false
//            self.spinner.startAnimating()
//        }
 
        if method == "GET" {
            
            let headers: HTTPHeaders = [:]
            print(headers)
            Alamofire.request(encodeURL, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                })
                switch(response.result)
                {
                case .success(_):
                    if response.result.value != nil
                    {
                        print(response.result.value ?? "")
                        completionHandler((response.data)!)
                    }
                    
                    break
                    
                case .failure(_):
                    
                    print(response.result.error ?? "")
                    
                    break
                }
            }
        }
      
       
      
       
    }
}
