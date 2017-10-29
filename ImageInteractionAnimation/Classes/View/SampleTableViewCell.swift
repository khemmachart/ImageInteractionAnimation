//
//  SampleTableViewCell.swift
//  InteractiveModalImageViewController
//
//  Created by KHUN NINE on 7/14/17.
//  Copyright © 2017 Santora Nakama. All rights reserved.
//

import UIKit

protocol SampleTableViewCellDelegate: class {
    
    func presentImageFrom(imageView: UIImageView?, atCell cell: SampleTableViewCell)
}

class SampleTableViewCell: UITableViewCell {
    
    weak var delegate: SampleTableViewCellDelegate?
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBAction func imageButtonDidPress(_ sender: UIButton) {
        delegate?.presentImageFrom(imageView: sender.imageView, atCell: self)
    }
    
}
