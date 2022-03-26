//
//  StorageManager.swift
//  PillApp
//
//  Created by anvar on 20/03/22.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}


func save(_ pillList: [PillList]) {
    try! realm.write{
        realm.add(pillList)
    }
}
    func save(_ pillList: PillList) {
        try! realm.write {
            realm.add(pillList)
        }
    }
    
    func delete(_ pillList: PillList) {
        write {
            realm.delete(pillList)
            realm.delete(pillList)
        }
    }
    func edit (_ pillList: PillList, newValue: String) {
        write {
            pillList.name = newValue
            
        }
    }
   
    
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
