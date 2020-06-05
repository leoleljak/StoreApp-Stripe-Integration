//
//  ViewController+Ext.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 04/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func displayAlertOnMainThread(for alertType:AlertType, autoHide: Bool?, title: String? ){
        DispatchQueue.main.async {
            let vc = LLCentralAlertVC(autoHide: autoHide, title: title, alertType: alertType)
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self as? LLCentralAlertVCDelegate
            vc.set(type: alertType)
            self.present(vc, animated: true, completion: nil)
            self.generateFeedback(type: alertType)
        }
        
    }
    
    
    func generateFeedback(type: AlertType) {
        let generator = UINotificationFeedbackGenerator()
        switch type {
        case .success:
            generator.notificationOccurred(.success)
        case .error:
            generator.notificationOccurred(.error)
        case .custom:
            generator.notificationOccurred(.error)
        }
    
    }
    
}
