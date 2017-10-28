//
//  ShowUserDisplayImageVIewContorller.swift
//  Hackaton
//
//  Created by KHUN NINE on 3/23/17.
//  Copyright © 2017 KHUN NINE. All rights reserved.
//


import UIKit

class DisplayImageViewController: UIViewController {
    
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    private lazy var displayImageView: UIImageView = {
        let imageView = UIImageView(frame: self.containerView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.image
        imageView.frame = self.senderFrame
        return imageView
    }()
    
    private lazy var actualFrame: CGRect = {
        return CGRect(x: 0,
                      y: 0,
                      width: self.view.frame.width,
                      height: self.view.frame.height)
    }()
    
    private lazy var senderFrame: CGRect = {
        if let sender = self.sender {
            let actualSenderPosition = sender.screenOrigin
            return CGRect(x: actualSenderPosition.x,
                          y: actualSenderPosition.y,
                          width: sender.frame.width,
                          height: sender.frame.height)
        }
        return CGRect.zero
    }()
    
    var presentHandler: (() -> Void)? = nil
    var dismissHandler: (() -> Void)? = nil
    
    var initialTouchPoint = CGPoint(x: 0,y: 0)
    let dragingDismissDistance: CGFloat = 80
    
    let duration: TimeInterval = 0.25
    var sender: UIView?
    var image: UIImage?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadeInAnimation()
    }
    
    // MARK: - Action
    
    @IBAction func dismissButtonDisPress(_ sender: UIView) {
        dismiss(animated: true)
    }
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        switch sender.state {
            
        case .began:
            initialTouchPoint = touchPoint
            
        case .changed:
            if overlayView.alpha > OverlayViewAlpha.prepare.rawValue {
                prepareFadeOutAnimation()
            }
            let yPosition = touchPoint.y - initialTouchPoint.y
            let xPosition = touchPoint.x - initialTouchPoint.x
            displayImageView.frame = CGRect(x: xPosition,
                                            y: yPosition,
                                            width: view.bounds.width,
                                            height: view.bounds.height)
            
        case .ended, .cancelled:
            if isReachedDismissPosition(curPosition: touchPoint) {
                dismiss(animated: true)
            } else {
                moveToActualPositionAnimation()
            }
            
        default: break
        }
    }
    
    // MARK: - Interface
    
    func setupInterfaceBeforeFadeAnimation() {
        overlayView.alpha = OverlayViewAlpha.begin.rawValue
        displayImageView.frame = senderFrame
    }
    
    func setupInterfaceAfterFadeAnimation() {
        overlayView.alpha = OverlayViewAlpha.finish.rawValue
        displayImageView.frame = actualFrame
    }
    
    func fadeInAnimation() {
        presentHandler?()
        setupInterfaceBeforeFadeAnimation()
        moveToActualPositionAnimation()
    }
    
    func moveToActualPositionAnimation() {
        UIView.animate(withDuration: duration, animations: {
            self.setupInterfaceAfterFadeAnimation()
        })
    }
    
    func fadeOutAnimation(completionHandler handler: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration * 2,
                       delay: 0.0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut],
                       animations: {
            self.setupInterfaceBeforeFadeAnimation()
        }, completion: { complete in
            self.dismissHandler?()
            handler?()
        })
    }
    
    func prepareFadeOutAnimation() {
        UIView.animate(withDuration: duration, animations: {
            self.overlayView.alpha = OverlayViewAlpha.prepare.rawValue
        })
    }
    
    // MARK: - Interface
    
    private func setupInterface() {
        setupInterfaceBeforeFadeAnimation()
        view.addSubview(displayImageView)
    }

    // MARK: - Utils
    
    private func isReachedDismissPosition(curPosition: CGPoint) -> Bool {
        let isOverYPosition = abs(curPosition.y - initialTouchPoint.y) > dragingDismissDistance
        let isOverXPosition = abs(curPosition.x - initialTouchPoint.x) > dragingDismissDistance
        return isOverYPosition || isOverXPosition
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if flag {
            fadeOutAnimation(completionHandler: {
                super.dismiss(animated: false, completion: completion)
            })
        } else {
            super.dismiss(animated: false, completion: completion)
        }
        
    }

    enum OverlayViewAlpha: CGFloat {
        case begin = 0
        case prepare = 0.7
        case finish = 0.9
    }
}
