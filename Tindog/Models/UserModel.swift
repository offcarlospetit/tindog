//
//  UserModel.swift
//  Tindog
//
//  Created by Carlos Petit on 14-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import Foundation
import Firebase

struct UserModel{
    let uid: String
    let email: String
    let provider: String
    let profileImage: String
    let displayName: String
    
    init?(snapshot: DataSnapshot){
        let uid = snapshot.key
        guard let dic = snapshot.value as? [String:Any],
                let email = dic["email"] as? String,
                let provider = dic["provider"] as? String,
                let displayname = dic["displayName"] as? String,
                let profileimage = dic["profileImage"] as? String
            else {
                return nil
            
        }
        
        self.uid = uid
        self.email = email
        self.provider = provider
        self.displayName = displayname
        self.profileImage = profileimage
    }
}
