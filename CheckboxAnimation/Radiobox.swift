
import UIKit

/* Selection box for selecting a singel item */

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
