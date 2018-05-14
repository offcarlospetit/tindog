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
    
    var base_ref: DatabaseReference {
        return _base_ref
    }
    
    var user_ref: DatabaseReference {
        return _user_ref
    }
    
    func createFireBaseDBUser(uid: String, userData: Dictionary<String, Any>){
        user_ref.child(uid).updateChildValues(userData)
    }
    
}


