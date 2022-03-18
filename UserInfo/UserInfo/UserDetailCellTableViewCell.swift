//
//  UserDetailCellTableViewCell.swift
//  UserInfo
//
//  Created by Tech on 3/18/22.
//

import UIKit

class UserDetailCellTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         setupUI()
    }
    
    var userList = NSArray()

    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        bgView.layer.cornerRadius =  5
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.backgroundColor =  .lightGray
        
        userName.textColor =  .white
        userEmail.textColor =  .white
        
        userName.font = UIFont.boldSystemFont(ofSize: 15)
        userEmail.font = UIFont.boldSystemFont(ofSize: 12)
        
        userImg.layer.cornerRadius = userImg.frame.width/2
    }
}



