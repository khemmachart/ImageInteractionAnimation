//
//  UIView+Origin.swift
//  ImageInteractionAnimation
//
//  Created by KHUN NINE on 8/23/17.
//  Copyright © 2017 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

extension UIView {
    
    func getActualOrigin() -> CGPoint {
        return calculateActualOrigin(from: self)
    }
    
    func calculateActualOrigin(from sender: UIView?) -> CGPoint {
        
        // Base case
        guard let  sender = sender else {
            return CGPoint.zero
        }
        
        // Call recursive to get the sender actual origin
        let superviewOrigin = calculateActualOrigin(from: sender.superview)
        var senderOrigin = sender.frame.origin
        
        // If this view is kind off UITableViewCell, it need to minus with the table view offsets
        if let tableViewCell = sender as? UITableViewCell,
            let tableView = tableViewCell.superview?.superview as? UITableView {
            senderOrigin = CGPoint(x: sender.frame.origin.x,
                                   y: sender.frame.origin.y - tableView.contentOffset.y)
        }
        
        // Return the actual origin
        return CGPoint(x: senderOrigin.x + superviewOrigin.x,
                       y: senderOrigin.y + superviewOrigin.y)
    }
}
