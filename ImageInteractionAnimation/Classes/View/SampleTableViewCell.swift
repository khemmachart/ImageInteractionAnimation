//
//  SampleTableViewCell.swift
//  InteractiveModalImageViewController
//
//  Created by KHUN NINE on 7/14/17.
//  Copyright © 2017 Santora Nakama. All rights reserved.
//

import UIKit

protocol SampleTableViewCellDelegate: class {
    
    func imageButtonDidPress(_ sender: UIView, with image: UIImage)
}

class SampleTableViewCell: UITableViewCell {
    
    weak var delegate: SampleTableViewCellDelegate?
    
    @IBOutlet weak var imageButton: UIButton!
    
    internal var myImage: UIImage! {
        didSet {
            self.imageButton.setImage(myImage, for: .normal)
        }
    }
    
    @IBAction func imageButtonDidPress(_ sender: UIButton) {
        delegate?.imageButtonDidPress(sender, with: myImage)
    }
    
}
