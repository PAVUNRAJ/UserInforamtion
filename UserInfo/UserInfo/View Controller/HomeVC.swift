//
//  HomeVC.swift
//  UserInfo
//
//  Created by Tech on 3/18/22.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
    
    // IBOutlets
    
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.register(UserDetailCellTableViewCell.nib, forCellReuseIdentifier: UserDetailCellTableViewCell.identifier)
            tblView.dataSource = self
            tblView.separatorStyle = .none
            tblView.delegate = self
            tblView.backgroundColor = UIColor.clear
            tblView.translatesAutoresizingMaskIntoConstraints = false
            tblView.tableFooterView = UIView()
        }
    }
    
    
    var userList = NSArray()
    var dict = NSDictionary ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        callUserDetailAPI()
    }
    
    func setupUI(){
        self.navigationItem.title = "User Information"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightHandAction))
        
        // Referance purpose for getUserDetails
        
        let itemDetails = DBManager.sharedInstance.fetchUserDetails()
        for i in 0..<itemDetails.count {
            let itemObject = itemDetails[i] as? UserInfo
            let name  =   itemObject?.value(forKey: "first_name")
            print(name!)
            
        }
    }
    
    
}

extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard  let userDetail = storyBoard.instantiateViewController(withIdentifier: "UserInfoVC") as? UserInfoVC
        else{
            return
        }
        
        userDetail.userInfo = self.userList[indexPath.row] as? NSDictionary ?? [:]
        userDetail.edit = true
        navigationController?.pushViewController(userDetail, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let edit = UIContextualAction(style: .normal,
                                      title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.userProfileEdit(indexpath: indexPath.row)
            completionHandler(true)
        }
        edit.backgroundColor = .systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [edit])
        
        return configuration
    }
    
    
}



extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCellTableViewCell") as! UserDetailCellTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        dict  = self.userList[indexPath.row] as? NSDictionary ?? [:]
        cell.userName.text = "\(dict.value(forKey: "first_name") as? String ?? "") \(dict.value(forKey: "last_name") as? String ?? "")"
        cell.userEmail.text = "\(dict.value(forKey: "email") as? String ?? "")"
        let image = "\(dict.value(forKey: "avatar") ?? "")"
        let fileUrl = NSURL(string:image)
        cell.userImg.downloaded(from: fileUrl! as URL)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension HomeVC {
    
    
    func callUserDetailAPI(){
        
        let postDict : NSMutableDictionary = NSMutableDictionary()
        
        WebService().callAPI(url: Constant.BaseURL, method: "GET", post: postDict, completionHandler: { (data) in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary ?? [:]
                
                self.userList = json.value(forKey: "data") as? NSArray ?? []
                print(self.userList)
                
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
                
                
                
            }
            catch {
                print(error.localizedDescription)
            }
        })
    }
}


extension HomeVC{
    
    @objc func rightHandAction() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard  let userDetail = storyBoard.instantiateViewController(withIdentifier: "UserInfoVC") as? UserInfoVC
        else{
            return
        }
        userDetail.edit = false
        navigationController?.pushViewController(userDetail, animated: true)
    }
    
    
    @objc func userProfileEdit(indexpath:Int){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard  let userDetail = storyBoard.instantiateViewController(withIdentifier: "UserInfoVC") as? UserInfoVC
        else{
            return
        }
        
        userDetail.userInfo = self.userList[indexpath] as? NSDictionary ?? [:]
        userDetail.edit = true
        userDetail.fromAdd = true
        navigationController?.pushViewController(userDetail, animated: true)
    }
}
