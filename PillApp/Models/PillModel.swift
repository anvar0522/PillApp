//
//  PillModel.swift
//  PillApp
//
//  Created by anvar on 20/03/22.
//

import RealmSwift

class PillList: Object {
    @Persisted var name = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isCompleted = false   
}

