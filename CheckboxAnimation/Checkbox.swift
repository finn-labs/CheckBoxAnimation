import UIKit

protocol CheckboxDelegate: class {
    func checkbox(_ checkbox: Checkbox, didSelectItem item: CheckboxItem)
}

class Checkbox: UIView {
    
    @objc dynamic var textColor: UIColor {
        get { return CheckboxItem.appearance().textColor }
        set { CheckboxItem.appearance().textColor = newValue }
    }
    
    @objc dynamic var font: UIFont {
        get { return CheckboxItem.appearance().font }
        set { CheckboxItem.appearance().font = newValue }
    }
    
    var contentInsets: UIEdgeInsets = .zero {
        didSet {
            constraint(with: contentInsets)
        }
    }
    
    var unselectedImage: UIImage? {
        didSet {
            for item in stack.arrangedSubviews as! [CheckboxItem] {
                item.imageView.image = unselectedImage
            }
        }
    }
    
    var unselectedAnimationImages: [UIImage]? {
        didSet {
            for item in stack.arrangedSubviews as! [CheckboxItem] {
                item.imageView.animationImages = unselectedAnimationImages
                if let unselected = unselectedAnimationImages {
                    item.imageView.unselectedDuration = Double(unselected.count) / 60.0
                }
            }
        }
    }
    
    var selectedImage: UIImage? {
        didSet {
            for item in stack.arrangedSubviews as! [CheckboxItem] {
                item.imageView.highlightedImage = selectedImage
            }
        }
    }
    
    var selectedAnimationImages: [UIImage]? {
        didSet {
            for item in stack.arrangedSubviews as! [CheckboxItem] {
                item.imageView.highlightedAnimationImages = selectedAnimationImages
                if let selected = selectedAnimationImages {
                    item.imageView.selectedDuration = Double(selected.count) / 60.0
                }
            }
        }
    }
    
    weak var delegate: CheckboxDelegate?
    
    // MARK: Private properties
    
    private var leftConstraint, topConstraint, rightConstraint, bottomConstraint: NSLayoutConstraint!
    
    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(strings: [String]) {
        super.init(frame: .zero)
        setupBoxes(with: strings)
        setupTapGesture()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let view = hitTest(sender.location(in: self), with: nil) as? CheckboxItem else { return }
        view.isSelected = !view.isSelected
        delegate?.checkbox(self, didSelectItem: view)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupBoxes(with strings: [String]) {
        for string in strings {
            let item = CheckboxItem(frame: .zero)
            item.label.text = string
            stack.addArrangedSubview(item)
        }
        addSubview(stack)
        leftConstraint = stack.leftAnchor.constraint(equalTo: leftAnchor)
        topConstraint = stack.topAnchor.constraint(equalTo: topAnchor)
        rightConstraint = stack.rightAnchor.constraint(equalTo: rightAnchor)
        bottomConstraint = stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
    }
    
    private func constraint(with contentInsets: UIEdgeInsets) {
        leftConstraint.constant = contentInsets.left
        topConstraint.constant = contentInsets.top
        rightConstraint.constant = -contentInsets.right
        bottomConstraint.constant = -contentInsets.bottom
        if superview != nil {
            layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
