//
//  DatabaseSave.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/8/22.
//

import Foundation
import Firebase
import FirebaseFirestore

class DatabaseSave{
    let db = Firestore.firestore()
    
    func saveData(){
        var id = UUID().uuidString
        var ref: DocumentReference? = nil
        ref = db.collection("UsersPokemon").addDocument(data: [
            "currentPokemon": "Dibby",
            "isBaby": true,
            "currentMaxXP": 77,
            "currentChain": ["log", "dog","cog"],
            "listOfMon": [""],
            "ID": id
        ]) { err in
            if let error = err{
                print("error adding document : \(error.localizedDescription)")
            } else{
                print("Document added")
            }
        }
        print("cringe")
        let pog = db.collection("UsersPokemon")
        let query = pog.whereField("ID", isEqualTo: id)
        query.getDocuments() { pog, error in
            print(pog?.documents[0]["ID"])
        }
    }
}
