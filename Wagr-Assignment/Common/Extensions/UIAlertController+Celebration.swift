//
//  UIAlertController+Celebration.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-29.
//

import UIKit

extension UIAlertController {
    
    static func celebrationActionSheet(host: UIViewController, game: Game) -> UIAlertController {
        let controller = UIAlertController(title: "Select your celebration type", message: "", preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Modal", style: .default, handler: { (action) in
            let modalCelebration = ModalCelebrationViewController()
            modalCelebration.modalPresentationStyle = .overFullScreen
            modalCelebration.modalTransitionStyle = .crossDissolve
            
            host.present(modalCelebration, animated: true)
        }))
        controller.addAction(UIAlertAction(title: "Fullscreen", style: .default, handler: { (action) in
            let fullScreenCelebration = FullScreenCelebrationViewController(game: game)
            host.navigationController?.pushViewController(fullScreenCelebration, animated: true)
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        return controller
    }
    
}
