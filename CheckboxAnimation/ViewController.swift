import UIKit

class ViewController: UIViewController {
    
    let strings = ["Mistanke om svindel",
                   "Regelbrudd",
                   "Forhandler opptrer som privat"]
    
    lazy var checkbox: Radiobox = {
        let box = Radiobox(strings: strings)
        box.title = "Hva gjelder det?"
        box.delegate = self
        box.font = .systemFont(ofSize: 16)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedAnimationImage = UIImage.animatedImageNamed("checkbox-selected-", duration: 20 / 60.0)
        let unselectedAnimationImage = UIImage.animatedImageNamed("checkbox-unselected-", duration: 14 / 60.0)
        
        checkbox.selectedImage = selectedAnimationImage?.images?.last
        checkbox.selectedAnimationImages = selectedAnimationImage?.images
        checkbox.unselectedImage = unselectedAnimationImage?.images?.last
        checkbox.unselectedAnimationImages = unselectedAnimationImage?.images
        
        view.backgroundColor = .white
        view.addSubview(checkbox)
        NSLayoutConstraint.activate([
            checkbox.leftAnchor.constraint(equalTo: view.leftAnchor),
            checkbox.rightAnchor.constraint(equalTo: view.rightAnchor),
            checkbox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkbox.heightAnchor.constraint(equalToConstant: CGFloat(strings.count + 1) * 44),
        ])
    }
}

extension ViewController: SelectionBoxDelegate {

    func selectionbox(_ selectionbox: SelectionBox, didSelectItem item: SelectionBoxItem) {
        print("Did select item:", item)
    }
    
    func selectionbox(_ selectionbox: SelectionBox, didUnselectItem item: SelectionBoxItem) {
        print("Did unselect item,", item)
    }
}
