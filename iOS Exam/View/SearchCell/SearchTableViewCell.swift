//
//  SearchTableViewCell.swift
//  iOS Exam
//
//  Created by Gireesh on 16/07/21.
//

import UIKit

protocol SearchDelegate {
    func searchTextChanged(text:String)
}
class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTxt: UITextField!
    var delegate:SearchDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray)
                
                let attachmentString = NSMutableAttributedString(attachment: attachment)
        attachmentString.append(NSAttributedString(string: " Search", attributes: nil))
        searchTxt.attributedPlaceholder = attachmentString
        searchTxt.delegate = self
        searchTxt.addTarget(self, action: #selector(self.searchTextChanged(txt:)), for: .editingChanged)
        
    }
    @objc func searchTextChanged(txt:UITextField){
        delegate?.searchTextChanged(text: txt.text ?? "")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SearchTableViewCell:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxt.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchTextChanged(text: textField.text ?? "")
    }
}
