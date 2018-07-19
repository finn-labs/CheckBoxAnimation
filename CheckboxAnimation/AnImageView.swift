//
//  AnImageView.swift
//  CheckboxAnimation
//
//  Created by Granheim Brustad , Henrik on 19/07/2018.
//  Copyright © 2018 Granheim Brustad , Henrik. All rights reserved.
//

import UIKit

class AnImageView: UIImageView {
    
    private var startTime: TimeInterval?
    private var reverseImageView: UIImageView? // Used for reversing an animation
    
    var selectedDuration = 0.0
    var unselectedDuration = 0.0
    
    override func startAnimating() {
        if let reverse = reverseImageView {
            reverse.removeFromSuperview()
            reverseImageView = nil
        }
        
        super.startAnimating()
        startTime = CACurrentMediaTime()
    }
    
    func cancelAnimation() {
        super.stopAnimating()
        // Get current animation frame
        guard let startTime = startTime else { return }
        let elapsed = CACurrentMediaTime() - startTime
        let frame = Int(60.0 * elapsed)
        
        guard let images = isHighlighted ? highlightedAnimationImages : animationImages else { return }
        guard frame < images.count else { return }
        
        let sequence = images[..<frame].reversed()
        
        let reverse = UIImageView(frame: bounds)
        addSubview(reverse)
        
        reverse.image = sequence.last
        reverse.animationRepeatCount = 1
        reverse.animationImages = Array(sequence)
        reverse.animationDuration = Double(sequence.count) / 60.0
        reverse.startAnimating()
        reverseImageView = reverse
    }
}
