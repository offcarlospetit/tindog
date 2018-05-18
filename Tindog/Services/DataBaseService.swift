//
//  DataBaseService.swift
//  Tindog
//
//  Created by Carlos Petit on 12-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import Foundation
import Firebase

//configaramos la conexion a firebase
let DB_BASE_ROOT = Firebase.Database.database().reference() //importamos el id de la bd

class DataBaseService {
    static let instans = DataBaseService()
    private let _base_ref = DB_BASE_ROOT
    private let _user_ref = DB_BASE_ROOT.child("users")
    private let _match_ref = DB_BASE_ROOT.child("match")
    
    var base_ref: DatabaseReference {
        return _base_ref
    }
    
    var user_ref: DatabaseReference {
        return _user_ref
    }
    
    var match_ref: DatabaseReference {
        return _match_ref
    }
    
    func observeUserProfile(handler: @escaping(_ userProfileDict: UserModel?)->Void ){
        if let currentUser = Auth.auth().currentUser{
            DataBaseService.instans.user_ref.child(currentUser.uid).observe(.value, with: {(snapshot) in
                if let userDict = UserModel(snapshot: snapshot){
                    handler(userDict)
                }
            })
        }
    }
    
    func createFireBaseDBUser(uid: String, userData: Dictionary<String, Any>){
        user_ref.child(uid).updateChildValues(userData)
    }
    
    func createFireBaseMatch(uid: String, uid2: String){
        match_ref.child(uid).updateChildValues(["uid2": uid2, "matchIsAccepter": false])
    }
    
}


