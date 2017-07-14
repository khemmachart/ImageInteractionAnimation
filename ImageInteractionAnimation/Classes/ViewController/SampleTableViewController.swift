//
//  SampleTableViewController.swift
//  SNTPhotoInteractionAnimation
//
//  Created by KHUN NINE on 7/14/17.
//  Copyright © 2017 Santora Nakama. All rights reserved.
//

import UIKit

class SampleTableViewController: UIViewController {
    
    lazy var imageName: String = "DSCF0855.jpg"
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewCellSelfSizing()
    }
    
    func setTableViewCellSelfSizing() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    // MARK: - Util
    
    func presentImageViewController(_ sender: UIView, with image: UIImage) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let sID = "DisplayImageViewController"
        if let viewController = stroyboard.instantiateViewController(withIdentifier: sID) as? DisplayImageViewController {
            viewController.sender = sender
            viewController.image = image
            present(viewController, animated: false, completion: nil)
        }
    }
}

extension SampleTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SampleTableViewCell", for: indexPath) as? SampleTableViewCell {
            cell.myImage = UIImage(named: imageName)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension SampleTableViewController: SampleTableViewCellDelegate {
    
    func imageButtonDidPress(_ sender: UIView, with image: UIImage) {
        presentImageViewController(sender, with: image)
    }
}
