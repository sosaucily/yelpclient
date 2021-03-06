//
//  FilterCell.swift
//  yelpclient
//
//  Created by Jesse Smith on 9/20/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

@objc protocol SwitchFilterCellDelegate {
    func setSwitch(message: String)
}

class SwitchFilterCell: UITableViewCell {

    var delegate: SwitchFilterCellDelegate?
    @IBOutlet weak var filterName: UILabel!
    
    @IBOutlet weak var filterSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func triggerSwitch(){
        self.delegate?.setSwitch(self.filterName.text!)
    }
    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        self.delegate?.sortValue(keys[row])
//    }

}
