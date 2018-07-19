import UIKit

protocol MultipleSelectionDelegate: class {
    func selection(_ selection: MultipleSelectionBox, didSelectItem item: CheckBox)
}

class MultipleSelectionBox: UIView {
    
    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let unselected = UIImage.animatedImageNamed("radiobutton-unselected-", duration: 14 / 60.0)
    private let selected = UIImage.animatedImageNamed("checkbox-selected-", duration: 20 / 60.0)
    
    weak var delegate: MultipleSelectionDelegate?
    
    init(strings: [String]) {
        super.init(frame: .zero)
        setupBoxes(with: strings)
        setupTapGesture()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let view = hitTest(sender.location(in: stack), with: nil) as? CheckBox else { return }
        view.isSelected = !view.isSelected
        delegate?.selection(self, didSelectItem: view)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupBoxes(with strings: [String]) {
        guard let selected = selected?.images, let unselected = unselected?.images else { return }
        
        for string in strings {
            let checkBox = CheckBox(selected: selected, unselected: unselected)
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
