
import UIKit

class Radiobox: SelectionBox {
    
    weak var selectedItem: SelectionBoxItem?
    
    override func handleSelecting(_ item: SelectionBoxItem) {
        
        selectedItem?.isSelected = false
        
        if item === selectedItem {
            selectedItem = nil
            return
        }
        
        item.isSelected = true
        selectedItem = item
        delegate?.selectionbox(self, didSelectItem: item)
    }
}
