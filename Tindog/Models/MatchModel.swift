//
//  MatchModel.swift
//  Tindog
//
//  Created by Carlos Petit on 19-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import Foundation
import Firebase

struct MatchModel {
    let uid: String
    let uid2: String
    let mathcIsAccepted: Bool
    
    init?(snapshot: DataSnapshot){
        let uid = snapshot.key
        guard let dic = snapshot.value as? [String:Any],
            let uid2 = dic["uid2"] as? String,
            let mathcIsAccepted = dic["mathcIsAccepted"] as? Bool
            else {
                return nil
                
        }
        self.uid = uid
        self.uid2 = uid2
        self.mathcIsAccepted = mathcIsAccepted
    }
}
