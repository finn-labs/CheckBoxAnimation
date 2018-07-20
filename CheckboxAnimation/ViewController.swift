import UIKit

class ViewController: UIViewController {
    
    let strings = ["Mistanke om svindel",
                   "Regelbrudd",
                   "Forhandler opptrer som privat"]
    
    lazy var checkbox: Checkbox = {
        let box = Checkbox(strings: strings)
        box.delegate = self
        box.contentInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        box.backgroundColor = .white
        box.layer.shadowOpacity = 0.3
        box.layer.shadowOffset = CGSize(width: 0, height: 4)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Checkbox.appearance().textColor = .darkGray
        Checkbox.appearance().font = .systemFont(ofSize: 16)
        
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
            checkbox.heightAnchor.constraint(equalToConstant: CGFloat(strings.count) * 44),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        checkbox.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension ViewController: CheckboxDelegate {

    func checkbox(_ checkbox: Checkbox, didSelectItem item: CheckboxItem) {
        print("Did select item:", item)
    }
}
