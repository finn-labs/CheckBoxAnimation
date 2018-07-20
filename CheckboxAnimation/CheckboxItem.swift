import UIKit

class CheckboxItem: UIView {
    
    let imageView: AnimatedImageView = {
        let view = AnimatedImageView(frame: .zero)
        view.animationRepeatCount = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
    
    @objc dynamic var textColor: UIColor {
        get { return label.textColor }
        set { label.textColor = newValue }
    }
    
    @objc dynamic var font: UIFont {
        get { return label.font }
        set { label.font = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    private func animateImage(selected: Bool) {
        if imageView.isAnimating {
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
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
