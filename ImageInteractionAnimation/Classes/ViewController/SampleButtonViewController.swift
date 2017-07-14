//
//  ViewController.swift
//  SNTPhotoInteractionAnimation
//
//  Created by KHUN NINE on 7/5/17.
//  Copyright © 2017 Santora Nakama. All rights reserved.
//

import UIKit

class SampleButtonViewController: UIViewController {
    
    lazy var imageToShow: UIImage? = UIImage(named: "DSCF0855.jpg")
    
    // MARK: - Action
    
    @IBAction func imageButtonDidPress(_ sender: UIView) {
        presentImageViewController(sender)
    }
    
    // MARK: - Util
    
    private func presentImageViewController(_ sender: UIView) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let sID = "DisplayImageViewController"
        if let viewController = stroyboard.instantiateViewController(withIdentifier: sID) as? DisplayImageViewController {
            viewController.sender = sender
            viewController.image = imageToShow
            present(viewController, animated: false, completion: nil)
        }
        
    }
}
