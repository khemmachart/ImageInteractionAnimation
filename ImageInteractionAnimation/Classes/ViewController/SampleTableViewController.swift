//
//  SampleTableViewController.swift
//  InteractiveModalImageViewController
//
//  Created by KHUN NINE on 7/14/17.
//  Copyright © 2017 Santora Nakama. All rights reserved.
//

import UIKit

class SampleTableViewController: UIViewController {
    
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
    
    fileprivate func presentImageViewController(
        _ sender: UIImageView?,
        presentHandler: (() -> Void)? = nil,
        dismissHandler: (() -> Void)? = nil) {
        
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let sID = "InteractiveModalImageViewController"
        if let viewController = stroyboard.instantiateViewController(withIdentifier: sID) as? InteractiveModalImageViewController {
            viewController.superview = view
            viewController.sender = sender
            viewController.image = sender?.image
            viewController.dismissHandler = dismissHandler
            viewController.presentHandler = presentHandler
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
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension SampleTableViewController: SampleTableViewCellDelegate {
    
    func presentImageFrom(imageView: UIImageView?, atCell cell: SampleTableViewCell) {
        presentImageViewController(
            imageView,
            presentHandler: { cell.imageButton.isHidden = true },
            dismissHandler: { cell.imageButton.isHidden = false })
    }
}
