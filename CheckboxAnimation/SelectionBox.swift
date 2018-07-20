
import UIKit

protocol SelectionBoxDelegate: class {
    func selectionbox(_ selectionbox: SelectionBox, didSelectItem item: SelectionBoxItem)
    func selectionbox(_ selectionbox: SelectionBox, didUnselectItem item: SelectionBoxItem)
}

class SelectionBox: UIView {
    
    var unselectedImage: UIImage? {
        didSet {
            for item in stack.arrangedSubviews as! [SelectionBoxItem] {
                item.imageView.image = unselectedImage
            }
        }
    }
    
    var unselectedAnimationImages: [UIImage]? {
        didSet {
            for item in stack.arrangedSubviews as! [SelectionBoxItem] {
                item.imageView.animationImages = unselectedAnimationImages
                if let unselected = unselectedAnimationImages {
                    item.imageView.unselectedDuration = Double(unselected.count) / 60.0
                }
            }
        }
    }
    
    var selectedImage: UIImage? {
        didSet {
            for item in stack.arrangedSubviews as! [SelectionBoxItem] {
                item.imageView.highlightedImage = selectedImage
            }
        }
    }
    
    var selectedAnimationImages: [UIImage]? {
        didSet {
            for item in stack.arrangedSubviews as! [SelectionBoxItem] {
                item.imageView.highlightedAnimationImages = selectedAnimationImages
                if let selected = selectedAnimationImages {
                    item.imageView.selectedDuration = Double(selected.count) / 60.0
                }
            }
        }
    }
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    weak var delegate: SelectionBoxDelegate?
    
    // MARK: Private properties
    
    private var highlightedItem: SelectionBoxItem?
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Implementation
    
    init(strings: [String]) {
        super.init(frame: .zero)
        setupBoxes(with: strings)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard let item = hitTest(location, with: event) as? SelectionBoxItem else { return }
        highlightedItem = item
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard let item = hitTest(location, with: event) as? SelectionBoxItem else { return }
        guard item === highlightedItem else { return }
        handleSelecting(item)
    }
    
    public func handleSelecting(_ item: SelectionBoxItem) {
        fatalError("This class should not be used directly")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectionBox {
    
    private func setupBoxes(with strings: [String]) {
        for string in strings {
            let item = SelectionBoxItem(frame: .zero)
            item.label.text = string
            stack.addArrangedSubview(item)
        }
        addSubview(titleLabel)
        addSubview(stack)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension SelectionBox {
    
    @objc dynamic var textColor: UIColor {
        get { return SelectionBoxItem.appearance().textColor }
        set { SelectionBoxItem.appearance().textColor = newValue }
    }
    
    @objc dynamic var font: UIFont {
        get { return SelectionBoxItem.appearance().font }
        set { SelectionBoxItem.appearance().font = newValue }
    }
}
