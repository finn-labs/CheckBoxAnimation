import UIKit

class ViewController: UIViewController, CheckboxDelegate {
    
    let strings = ["Mistanke om svindel",
                   "Regelbrudd",
                   "Forhandler opptrer som privat"]
    
    lazy var selectionBox: Checkbox = {
        let box = Checkbox(strings: strings)
        box.delegate = self
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(selectionBox)
        NSLayoutConstraint.activate([
            selectionBox.leftAnchor.constraint(equalTo: view.leftAnchor),
            selectionBox.rightAnchor.constraint(equalTo: view.rightAnchor),
            selectionBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selectionBox.heightAnchor.constraint(equalToConstant: CGFloat(strings.count) * 44),
        ])
    }
    
    func checkbox(_ checkbox: Checkbox, didSelectItem item: CheckboxItem) {
        print("Did select item:", item)
    }
}

