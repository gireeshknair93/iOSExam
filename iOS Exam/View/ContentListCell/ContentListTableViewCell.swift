//
//  ContentListTableViewCell.swift
//  iOS Exam
//
//  Created by Gireesh on 16/07/21.
//

import UIKit

class ContentListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadDataOnCell(model:HomeSubList?){
        if let model = model{
        self.imageView?.image = UIImage(named: "listIcon")
        self.textLabel?.text = model.title
        }
    }
}
