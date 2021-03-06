//
//  MainTabBarController.swift
//  Stalarm
//
//  Created by Andrean Lay on 28/04/21.
//

import UIKit

class MainTabBar: UITabBar {
    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        self.drawShape()
    }
    
    private func drawShape() {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = createPath()
            shapeLayer.fillColor = #colorLiteral(red: 0.9782002568, green: 0.9782230258, blue: 0.9782107472, alpha: 1)
            shapeLayer.lineWidth = 1
            shapeLayer.shadowOffset = CGSize(width:0, height:0)
            shapeLayer.shadowRadius = 10
            shapeLayer.shadowColor = UIColor.gray.cgColor
            shapeLayer.shadowOpacity = 0.3

            if let oldShapeLayer = self.shapeLayer {
                self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
            } else {
                self.layer.insertSublayer(shapeLayer, at: 0)
            }
            self.shapeLayer = shapeLayer
        }

    private func createPath() -> CGPath {
        let height: CGFloat = 86.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height), y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: 30, startAngle: CGFloat.pi, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

