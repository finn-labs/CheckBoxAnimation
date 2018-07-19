import UIKit

class CheckBox: UIView {
    
    let imageView: AnimatedImageView
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var isSelected = false {
        didSet {
            animateImage(selected: isSelected)
        }
    }
    
    init(selected: [UIImage], unselected: [UIImage]) {
        imageView = AnimatedImageView(image: unselected.last, highlightedImage: selected.last)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.animationImages = unselected
        imageView.highlightedAnimationImages = selected
        imageView.animationRepeatCount = 1
        imageView.selectedDuration = Double(selected.count) / 60.0
        imageView.unselectedDuration = Double(unselected.count) / 60.0
        super.init(frame: .zero)
        setupSubviews()
    }
    
    private func animateImage(selected: Bool) {
        if imageView.isAnimating {
            print("cancel")
            imageView.cancelAnimation()
            imageView.isHighlighted = selected
            return
        }
        
        imageView.isHighlighted = selected
        imageView.animationDuration = selected ? imageView.selectedDuration : imageView.unselectedDuration
        imageView.startAnimating()
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
