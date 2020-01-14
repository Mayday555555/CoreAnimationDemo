//
//  ViewController.swift
//  CoreAnimationDemo
//
//  Created by xuanze on 2019/10/14.
//  Copyright © 2019 xuanze. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    private var baseView: UIView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBaseView()
        self.animationGroup()
    }

    private func setBaseView() {
        self.baseView = UIView()
        self.baseView.backgroundColor = UIColor.blue
        self.baseView.frame = CGRect(x: 200, y: 200, width: 20, height: 20)
        self.view.addSubview(self.baseView)
    }

    private func uiviewAnimation() {
        UIView.animate(withDuration: 2, animations: {
            self.baseView.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        }) { (finished) in
            self.baseView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        }
    }
    
    private func uiviewComit() {
//        UIView.beginAnimations(<#T##animationID: String?##String?#>, context: <#T##UnsafeMutableRawPointer?#>)
    }
    
    private func baseAnimationScale() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.isRemovedOnCompletion = true
        animation.beginTime = CACurrentMediaTime() + 2
        animation.duration = 5
        animation.speed = 1
        animation.timeOffset = 2
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = false
        animation.fillMode = .backwards
        animation.delegate = self
        animation.byValue = 3.0
        
        baseView.layer.add(animation, forKey: "Mscale")
    }
    
    private func baseAnimationTransform() {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.isRemovedOnCompletion = true
        animation.beginTime = 0
        animation.duration = 2
        animation.speed = 1
        animation.timeOffset = 0
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = false
        animation.fillMode = .backwards
        animation.delegate = self
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500.0
        transform = CATransform3DRotate(transform, CGFloat(Double.pi / 4), 1, 0, 0)
        animation.toValue = transform
        
        baseView.layer.add(animation, forKey: "Mtransform")
    }
    
    private func keyAnimation() {
        let keyAnimation = CAKeyframeAnimation(keyPath: "position")
        keyAnimation.values = [CGPoint(x: 50, y: 50) ,CGPoint(x: 200, y: 50), CGPoint(x: 200, y: 200), CGPoint(x: 50, y: 200)]
        keyAnimation.keyTimes = [0.0, 0.1, 0.2, 1]
        keyAnimation.isRemovedOnCompletion = false
        keyAnimation.autoreverses = true
        keyAnimation.duration = 29
        keyAnimation.calculationMode = .linear
        keyAnimation.rotationMode = .rotateAutoReverse
        keyAnimation.fillMode = .forwards
        
//        let path = CGMutablePath()
//        path.addArc(center: baseView.center, radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
//        keyAnimation.path = path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 200, y: 200))
        keyAnimation.path = path.cgPath
        
        keyAnimation.repeatCount = MAXFLOAT
        baseView.layer.add(keyAnimation, forKey: "KeyPositionAnimation")
    }
    
    private func uiviewSpring() {
        UIView.animate(withDuration: 6, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIView.AnimationOptions.autoreverse, animations: {
            self.baseView.transform = CGAffineTransform(translationX: 30, y: 30)
        }) { (finished) in
            
        }
    }
    
    private func animationSpring() {
        let springAnimation = CASpringAnimation(keyPath: "position")
        springAnimation.fromValue = CGPoint(x: 50, y: 50)
        springAnimation.toValue = CGPoint(x: 200, y: 200)
        springAnimation.duration = 29
        springAnimation.damping = 0.6
        springAnimation.mass = 0.1
        springAnimation.isRemovedOnCompletion = false
        springAnimation.autoreverses = true
        springAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        baseView.layer.add(springAnimation, forKey: "springAnima")
    }
    
    private func transform() {
//        UIView.animate(withDuration: 2) {
////            self.baseView.transform = __CGAffineTransformMake(1, 0, 0, 1, -100, 0)
////            self.baseView.transform = CGAffineTransform(translationX: 50, y: 50)
////            self.baseView.transform = self.baseView.transform.translatedBy(x: 100, y: 100)
////            self.baseView.transform = CGAffineTransform(scaleX: 2, y: 3)
////            self.baseView.transform = self.baseView.transform.scaledBy(x: 2, y: 3)
////            self.baseView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
////
////            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
////                self.baseView.transform = self.baseView.transform.rotated(by: CGFloat(Double.pi))
////            }
//
////            self.baseView.transform = self.baseView.transform.rotated(by: CGFloat(Double.pi))
//            let transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
//            self.baseView.transform = transform
//            self.baseView.transform.inverted()
//        }
        
        UIView.animate(withDuration: 2, animations: {
            let transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
//            CGAffineTransformConcat
            
            self.baseView.transform = transform.concatenating(CGAffineTransform(scaleX: 2, y: 2))
        }) { (finished) in
            self.baseView.transform = CGAffineTransform.identity
        }
    }
    
    private func animationGroup() {
        let baseAnimation = CABasicAnimation(keyPath: "transform.scale")
        baseAnimation.fromValue = 0.5
        baseAnimation.toValue = 2
        
        let keyAnimaiton = CAKeyframeAnimation(keyPath: "opacity")
        keyAnimaiton.values = [1, 0.9, 0.8, 0.7, 0.6 ,0.5, 0.4, 0.3, 0.2, 0.1, 0]
        keyAnimaiton.keyTimes = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7,0.8, 0.9, 1]
        
        let group = CAAnimationGroup()
        group.fillMode = .forwards
        group.repeatCount = MAXFLOAT
        group.duration = 3
        group.isRemovedOnCompletion = false
        group.timingFunction = .init(name: CAMediaTimingFunctionName.easeInEaseOut)
        group.animations = [baseAnimation, keyAnimaiton]
        
        self.baseView.layer.add(group, forKey: "group")
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    }
    
    
    @IBAction func btn1Tap(_ sender: Any) {
        //覆盖
        let animation = CATransition()
        animation.type = .push
        animation.subtype = .fromLeft
        animation.fillMode = .forwards
        animation.duration = 2
        containView.layer.add(animation, forKey: "moveIn")
        containView.exchangeSubview(at: 0, withSubviewAt: 1)
    }
    
    @IBAction func btn2Tap(_ sender: Any) {
        let animation = CATransition()
        animation.type = .init(rawValue: "cube")
        animation.subtype = .fromLeft
        animation.fillMode = .forwards
        animation.duration = 2
        containView.layer.add(animation, forKey: "moveIn")
        containView.exchangeSubview(at: 0, withSubviewAt: 1)
    }
    
    @IBAction func btn3Tap(_ sender: Any) {
        let animation = CATransition()
        animation.type = .init(rawValue: "pageCurl")
        animation.subtype = .fromLeft
        animation.fillMode = .forwards
        animation.duration = 2
        containView.layer.add(animation, forKey: "moveIn")
        containView.exchangeSubview(at: 0, withSubviewAt: 1)
    }
    
}

