//
//  MainViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 29/04/21.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        if let navFrame = self.navigationController?.navigationBar.frame {
            let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            let newframe = CGRect(origin: .zero, size: CGSize(width: navFrame.width, height: (navFrame.height + statusBarHeight)))

            let image = gradientWithFrametoImage(frame: newframe, colors: [#colorLiteral(red: 0.5098039216, green: 0.4470588235, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.5921568627, green: 0.3921568627, blue: 0.7607843137, alpha: 1)])!

            let apperance = UINavigationBarAppearance()
            apperance.configureWithDefaultBackground()
            apperance.backgroundImage = image
            apperance.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]

            navigationController?.navigationBar.standardAppearance = apperance
            navigationController?.navigationBar.scrollEdgeAppearance = apperance
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func gradientWithFrametoImage(frame: CGRect, colors: [CGColor]) -> UIImage? {
        let gradient: CAGradientLayer  = CAGradientLayer(layer: self.view.layer)
        gradient.frame = frame
        gradient.colors = colors
        UIGraphicsBeginImageContext(frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
