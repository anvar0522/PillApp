//
//  PillCell.swift
//  PillApp
//
//  Created by anvar on 22/03/22.
//

import UIKit

class PillCell: UITableViewCell {
    
    @IBOutlet weak var pillNote: UILabel!
    @IBOutlet weak var pillName: UILabel!

    @IBOutlet weak var pillImg: UIImageView!
    @IBOutlet weak var pillTime: UILabel!
    
    func configure(with pill: PillList ) {
        
        pillName.text = pill.name
        pillNote.text = pill.note
        pillTime.text = pill.time
        pillImg.image = UIImage(named: "pillIcon")
        pillImg.layer.cornerRadius = pillImg.frame.height / 2
      
    }
    
    
}
