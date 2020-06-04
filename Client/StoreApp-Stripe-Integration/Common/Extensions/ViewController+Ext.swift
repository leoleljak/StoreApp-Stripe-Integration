//
//  ViewController+Ext.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 04/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func displayAlertOnMainThread(for alertType:AlertType){
        DispatchQueue.main.async {
            let vc = LLCentralAlertVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.vcToDismiss = self
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
        }
    
    }
    
}
