import UIKit

/* Selection box for selecting multiple items */

class Checkbox: SelectionBox {
    
    var selectedItems: Set<SelectionBoxItem> = []
    
    override func handleSelecting(_ item: SelectionBoxItem) {
        item.isSelected = !item.isSelected
        if item.isSelected {
            let result = selectedItems.insert(item)
            if result.inserted { delegate?.selectionbox(self, didSelectItem: result.memberAfterInsert) }
        } else {
            guard let removedItem = selectedItems.remove(item) else { return }
            delegate?.selectionbox(self, didUnselectItem: removedItem)
        }
    }
}
