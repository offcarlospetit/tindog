//
//  PerfilViewController.swift
//  Tindog
//
//  Created by Carlos Petit on 13-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class PerfilViewController: UIViewController {

    @IBOutlet weak var profileDisplayEmail: UILabel!
    @IBOutlet weak var profileDisplayName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var currentUserProfile: UserModel?

    @IBAction func importUsersAction(_ sender: Any) {
        let users  = [["email": "bruno@asd.com", "password": "123456", "displayName": "Bruno", "photoURL":"https://scontent.fscl6-1.fna.fbcdn.net/v/t1.0-9/26047264_10215254347736707_4161256811649393988_n.jpg?_nc_cat=0&oh=98cd1edfe7507dd9abe967a68b6273a7&oe=5B867232"],
                      ["email": "bublie@asd.com", "password": "123456", "displayName": "Bublie", "photoURL":"https://scontent.fscl6-1.fna.fbcdn.net/v/t1.0-9/26047264_10215254347736707_4161256811649393988_n.jpg?_nc_cat=0&oh=98cd1edfe7507dd9abe967a68b6273a7&oe=5B867232"],
                      ["email": "buddy@asd.com", "password": "123456", "displayName": "Buddy", "photoURL":"https://scontent.fscl6-1.fna.fbcdn.net/v/t1.0-9/26047264_10215254347736707_4161256811649393988_n.jpg?_nc_cat=0&oh=98cd1edfe7507dd9abe967a68b6273a7&oe=5B867232"],
                      ["email": "boss@asd.com", "password": "123456", "displayName": "Boss", "photoURL":"https://scontent.fscl6-1.fna.fbcdn.net/v/t1.0-9/26047264_10215254347736707_4161256811649393988_n.jpg?_nc_cat=0&oh=98cd1edfe7507dd9abe967a68b6273a7&oe=5B867232"],
                      ["email": "chipotle@asd.com", "password": "123456", "displayName": "Chipotle", "photoURL":"https://scontent.fscl6-1.fna.fbcdn.net/v/t1.0-9/26047264_10215254347736707_4161256811649393988_n.jpg?_nc_cat=0&oh=98cd1edfe7507dd9abe967a68b6273a7&oe=5B867232"]]
        
        for userDemo in users{
            Auth.auth().createUser(withEmail: userDemo["email"]!, password: userDemo["password"]!, completion: { (user, error) in
                if let user = user{
                    let userData = ["provider": user.providerID, "email": user.email!, "profileImage": userDemo["photoURL"]!, "displayName": userDemo["displayName"]!, "userIsOnMatch": false] as [String: Any]
                    DataBaseService.instans.createFireBaseDBUser(uid: user.uid, userData: userData)
                }
                
            })
        }
    }
    
    @IBAction func closeProfile(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.sd_setImage(with: URL(string: (self.currentUserProfile?.profileImage)!), completed: nil)
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.layer.borderWidth = 1.0
        self.profileImage.clipsToBounds = true
        
        self.profileDisplayEmail.text = self.currentUserProfile?.email
        
        self.profileDisplayName.text = self.currentUserProfile?.displayName
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    



}
