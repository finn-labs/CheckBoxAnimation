//
//  Checkbox.swift
//  CheckboxAnimation
//
//  Created by Granheim Brustad , Henrik on 18/07/2018.
//  Copyright © 2018 Granheim Brustad , Henrik. All rights reserved.
//

import UIKit

//class CheckBox: ToggleButton {
//    
//    override init(images: [UIImage], selectedImages: [UIImage]) {
//        super.init(images: images, selectedImages: selectedImages)
//    }
//    
//    init() {
//        let imagePaths = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "check-animation")
//        var images = [UIImage]()
//        imagePaths.sorted().forEach { (path) in
//            if let image = UIImage(contentsOfFile: path) {
//                images.append(image)
//            }
//        }
//        
//        let selectedImagePaths = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Uncheck@3x")
//        var selectedImages = [UIImage]()
//        selectedImagePaths.sorted().forEach { (path) in
//            if let image = UIImage(contentsOfFile: path) {
//                selectedImages.append(image)
//            }
//        }
//        
//        super.init(images: images, selectedImages: selectedImages)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}

class RadioButton: ToggleButton {}

class ToggleButton: UIControl {
    
    private lazy var imageView: AnimatableImageView = {
        let view = AnimatableImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Just a test :)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(images: [UIImage], selectedImages: [UIImage]) {
        super.init(frame: .zero)
        imageView.image = images.first
        imageView.animationImages = images
        imageView.highlightedImage = selectedImages.first
        imageView.highlightedAnimationImages = selectedImages
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 22),
            imageView.widthAnchor.constraint(equalToConstant: 22),
            
            textLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard !imageView.isRunning else {
            imageView.isReversed = true
            return
        }
        imageView.startAnimating(nil)
        isSelected = !isSelected
        super.sendAction(action, to: target, for: event)
    }
    
}
