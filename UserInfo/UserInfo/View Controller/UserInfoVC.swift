//
//  UserInfoVC.swift
//  UserInfo
//
//  Created by Tech on 3/18/22.
//

import UIKit

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var userlastNameTxtField: UITextField!
    @IBOutlet weak var userEmailTxtField: UITextField!
    @IBOutlet weak var userIdTxtField: UITextField!
    
    
    var userInfo = NSDictionary()
    var edit = Bool()
    var fromAdd = Bool()
    lazy var save = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserDetail()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupUserDetail(){
        
        if edit  {
            
            if fromAdd {
                
                userTxtField.isUserInteractionEnabled = true
                userlastNameTxtField.isUserInteractionEnabled = true
                userEmailTxtField.isUserInteractionEnabled = true
                userIdTxtField.isUserInteractionEnabled = true
                
                userTxtField.borderStyle = UITextField.BorderStyle.roundedRect
                userlastNameTxtField.borderStyle = UITextField.BorderStyle.roundedRect
                userEmailTxtField.borderStyle = UITextField.BorderStyle.roundedRect
                userIdTxtField.borderStyle = UITextField.BorderStyle.roundedRect
                
            }else{
                
                userTxtField.isUserInteractionEnabled = false
                userlastNameTxtField.isUserInteractionEnabled = false
                userEmailTxtField.isUserInteractionEnabled = false
                userIdTxtField.isUserInteractionEnabled = false
                
                userTxtField.borderStyle = UITextField.BorderStyle.none
                userlastNameTxtField.borderStyle = UITextField.BorderStyle.none
                userEmailTxtField.borderStyle = UITextField.BorderStyle.none
                userIdTxtField.borderStyle = UITextField.BorderStyle.none
                
            }
          
            
            
            userTxtField.text = ": \(userInfo.value(forKey: "first_name") as? String ?? "") "
            userlastNameTxtField.text = ": \(userInfo.value(forKey: "last_name") as? String ?? "")"
            userEmailTxtField.text = ": \(userInfo.value(forKey: "email") as? String ?? "")"
            userIdTxtField.text =  ": \(userInfo.value(forKey: "id") as? Int ?? 0)"
            
            
            let image = "\(userInfo.value(forKey: "avatar") ?? "")"
            let fileUrl = NSURL(string:image)
            userImg.downloaded(from: fileUrl! as URL)
            
        }
        else{
            
            userTxtField.isUserInteractionEnabled = true
            userlastNameTxtField.isUserInteractionEnabled = true
            userEmailTxtField.isUserInteractionEnabled = true
            userIdTxtField.isUserInteractionEnabled = true
            
            userTxtField.borderStyle = UITextField.BorderStyle.roundedRect
            userlastNameTxtField.borderStyle = UITextField.BorderStyle.roundedRect
            userEmailTxtField.borderStyle = UITextField.BorderStyle.roundedRect
            userIdTxtField.borderStyle = UITextField.BorderStyle.roundedRect
            
            userImg.image = UIImage(named: "user")
        }
        
        
        userName.text =  "User Name"
        userLastName.text = "User Last Name"
        userEmail.text =  "User Email Id"
        userId.text =  "User Id"
        
        userName.font = UIFont.systemFont(ofSize: 12)
        userEmail.font = UIFont.systemFont(ofSize: 12)
        userId.font = UIFont.systemFont(ofSize: 12)
        userLastName.font = UIFont.systemFont(ofSize: 12)
        
        
        userTxtField.font =  UIFont.boldSystemFont(ofSize: 15)
        userlastNameTxtField.font =  UIFont.boldSystemFont(ofSize: 15)
        userEmailTxtField.font =  UIFont.boldSystemFont(ofSize: 15)
        userIdTxtField.font =  UIFont.boldSystemFont(ofSize: 15) 
    
        userImg.layer.cornerRadius =  userImg.frame.width / 2
        
        
        // save the userDatas
        saveData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(saveAction))
        
    }
    
    
    func saveData(){
        
        if edit  {
            DBManager.sharedInstance.addUser(first_name: "\(userInfo.value(forKey: "first_name") as? String ?? "") ", last_name: "\(userInfo.value(forKey: "last_name") as? String ?? "")", email: "\(userInfo.value(forKey: "email") as? String ?? "")", avatar: "\(userInfo.value(forKey: "avatar") ?? "")", id: userInfo.value(forKey: "id") as! Int64)
          
        }else{
            DBManager.sharedInstance.addUser(first_name: userTxtField.text ?? "", last_name: userlastNameTxtField.text ?? "", email: userEmailTxtField.text ?? "", avatar: "", id: 0)
            
            
        }

    }
}


extension UserInfoVC {
    
    @objc func saveAction() {
            save = true
            saveData()
        }
}
