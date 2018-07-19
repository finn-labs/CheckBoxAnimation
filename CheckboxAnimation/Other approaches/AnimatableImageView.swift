//
//  AnimatableImageView.swift
//  CheckboxAnimation
//
//  Created by Granheim Brustad , Henrik on 18/07/2018.
//  Copyright © 2018 Granheim Brustad , Henrik. All rights reserved.
//

import UIKit

class AImageView: UIView, CAAnimationDelegate {
    
    private let onAnimation: [CGImage]
    private let offAnimation: [CGImage]
    var isSelected = false
    var isRunning = false
    var isReverse = false {
        didSet {
            stopAnimating()
        }
    }
    
    var runs = 0
    
    init(onAnimation: [CGImage], offAnimation: [CGImage]) {
        self.onAnimation = onAnimation
        self.offAnimation = offAnimation
        super.init(frame: .zero)
        layer.contents = onAnimation.first
    }
    
    func startAnimating() {
        guard !isRunning else { return }
        isSelected = !isSelected
        let sequence = isSelected ? onAnimation : offAnimation
        animate(sequence)
        isRunning = true
    }
    
    private func animate(_ sequence: [CGImage]) {
        let animation = CAKeyframeAnimation(keyPath: "contents")
        animation.delegate = self
        animation.calculationMode = kCAAnimationDiscrete
        animation.repeatCount = 1
        animation.values = sequence
        animation.duration = Double(sequence.count) / 60.0
        layer.contents = sequence.last
        layer.add(animation, forKey: "check")
    }
    
    private func reverse(from frame: Int) {
        guard isRunning else { return }
        var images = isSelected ? onAnimation : offAnimation
        let slice = images[..<frame].reversed()
        animate(Array(slice))
        isSelected = !isSelected
    }
    
    func stopAnimating() {
        layer.removeAnimation(forKey: "check")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if !flag {
            guard isRunning, isReverse else { return }
            let elapsedTime = CACurrentMediaTime() - anim.beginTime
            let currentFrame = Int(elapsedTime * 60.0)
            reverse(from: currentFrame)
            return
        }
        isRunning = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnimatableImageView: UIImageView {
    
    private var displayLink: CADisplayLink?
    private var currentFrame = 0
    private var frameUpdate = 1
    private var completion: (() -> Void)?
    private var displayedImages: [UIImage]?
    var isRunning = false
    var isReversed = false {
        didSet {
            if isReversed { frameUpdate = -1 }
            else { frameUpdate = 1 }
        }
    }
    var runs = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating(_ completion:(() -> Void)?) {
        self.completion = completion
        
        if isHighlighted {
            displayedImages = highlightedAnimationImages
            image = nil
        }
        else {
            displayedImages = animationImages
            highlightedImage = nil
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(step(displayLink:)))
        displayLink?.add(to: .main, forMode: .commonModes)
        isRunning = true
    }
    
    override func stopAnimating() {
        displayLink?.invalidate()
        isRunning = false
        currentFrame = 0
        
        if isHighlighted {
            if isReversed {
                highlightedImage = highlightedAnimationImages?.first
                isReversed = false
                return
            }
            image = animationImages?.first
        }
        else {
            if isReversed {
                image = animationImages?.first
                isReversed = false
                return
            }
            highlightedImage = highlightedAnimationImages?.first
        }
        isHighlighted = !isHighlighted
        
        if let completion = completion { completion() }
    }
    
    @objc func step(displayLink: CADisplayLink) {
        guard let images = displayedImages else { return }
        guard currentFrame >= 0, currentFrame < images.count else {
            displayLink.invalidate()
            currentFrame = 0
            runs += 1
            if runs < 20 {
                startAnimating(nil)
            }
//            stopAnimating()
            return
        }
        
        if isHighlighted { highlightedImage = images[currentFrame] }
        else { image = images[currentFrame] }
        
        currentFrame += frameUpdate
    }
}
