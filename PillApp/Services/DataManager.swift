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
        if !UserDefaults.standard.bool(forKey: "dadadada") {
         
            
            let kardiomagnil = PillList(value: ["Кардиомагнил 75","1 таблетка", ""])
            let azimac = PillList(value: ["Азимак","1 таблетка", ""])
            let yarina = PillList(value: ["Ярина","1 таблетка", ""])

            
            
            DispatchQueue.main.async {
                StorageManager.shared.save([kardiomagnil, azimac, yarina])
                UserDefaults.standard.set(true, forKey: "dadadada")
                completion()
            }
            
        }
    }
    
}
