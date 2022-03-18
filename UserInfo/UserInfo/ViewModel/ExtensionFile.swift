//
//  ExtensionFile.swift
//  UserInfo
//
//  Created by Tech on 3/18/22.
//

import Foundation
import UIKit


extension UIViewController{
    
    func navigationTitle(title:String){
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        navigationItem.titleView = titleLabel
    }
    
 

}
extension UIImageView {
    
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                }
            }.resume()
        }
}
