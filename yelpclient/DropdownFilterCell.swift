//
//  DropdownFilterCell.swift
//  yelpclient
//
//  Created by Jesse Smith on 9/21/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

@objc protocol DropdownFilterCellDelegate {
    func sortValue(message: String)
}

class DropdownFilterCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegate: DropdownFilterCellDelegate?
    var keys = ["best match","distance","highest rated"]
    
    @IBOutlet weak var dropdownPicker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(keys[row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.sortValue(keys[row])
    }

}
