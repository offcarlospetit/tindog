//
//  UpdateDBService.swift
//  Tindog
//
//  Created by Carlos Petit on 19-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import Foundation
import Firebase

class UpdateDBService {
    static let instance = UpdateDBService()
    
    func observerMatch(handler: @escaping(_ MatchDict: MatchModel? )->Void ){
        DataBaseService.instans.match_ref.observe(.value) {(snapshot) in
            if let matchSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                if matchSnapshot.count > 0{
                    for match in matchSnapshot {
                        if match.hasChild("uid2") && match.hasChild("mathcIsAccepted"){
                            if let matchDict = MatchModel(snapshot: match){
                                 handler(matchDict)
                            }
                        }
                    }
                }else{
                    handler(nil)
                }
            }
        }
    }
}
