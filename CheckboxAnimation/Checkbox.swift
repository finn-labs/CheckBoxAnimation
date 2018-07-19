import UIKit

protocol CheckboxDelegate: class {
    func checkbox(_ checkbox: Checkbox, didSelectItem item: CheckboxItem)
}

class Checkbox: UIView {
    
    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let unselectedImages = UIImage.animatedImageNamed("checkbox-unselected-", duration: 14 / 60.0)
    private let selectedImages = UIImage.animatedImageNamed("checkbox-selected-", duration: 20 / 60.0)
    
    weak var delegate: CheckboxDelegate?
    
    init(strings: [String]) {
        super.init(frame: .zero)
        setupBoxes(with: strings)
        setupTapGesture()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let view = hitTest(sender.location(in: stack), with: nil) as? CheckboxItem else { return }
        view.isSelected = !view.isSelected
        delegate?.checkbox(self, didSelectItem: view)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupBoxes(with strings: [String]) {
        guard let selected = selectedImages?.images, let unselected = unselectedImages?.images else { return }
        
        for string in strings {
            let checkBox = CheckboxItem(selectedImages: selected, unselectedImages: unselected)
            checkBox.label.text = string
            stack.addArrangedSubview(checkBox)
        }
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
