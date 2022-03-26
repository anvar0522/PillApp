//
//  DataManager.swift
//  PillApp
//
//  Created by anvar on 20/03/22.
//

import Foundation
import RealmSwift

struct DataManager {
    static let shared = DataManager()
   
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "anvar1234") {
         
//            let pillList = PillList()
            
            let kardiomagnil = PillList(value: ["Кардиомагнил 75","1 таблетка", Date(), false])
            let azimac = PillList(value: ["Азимак","1 таблетка", Date(), false])
            let yarina = PillList(value: ["Ярина","1 таблетка", Date(), false])
//            List(collection: [kardiomagnil, azimac, yarina])
//            pillList.pills.insert(contentsOf: [kardiomagnil, azimac, yarina], at: 0)
            
            
            
            DispatchQueue.main.async {
                StorageManager.shared.save([kardiomagnil, azimac, yarina])
                UserDefaults.standard.set(true, forKey: "anvar1234")
                completion()
            }
            
        }
    }
    
}
