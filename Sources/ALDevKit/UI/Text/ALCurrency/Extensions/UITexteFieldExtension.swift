//
//  UITexteFieldExtension.swift
//  Finance
//
//  Created by Alexandr Guzenko on 07.11.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

public extension UITextField {

    // MARK: Public

    var selectedTextRangeOffsetFromEnd: Int {
        return offset(from: endOfDocument, to: selectedTextRange?.end ?? endOfDocument)
    }
    
    /// Sets the selected text range when the text field is starting to be edited.
    /// Call this method when text field start to be the first responder.
    func setInitialSelectedTextRange() {
        updateSelectedTextRange(lastOffsetFromEnd: 0)
    }
    
    /// Update the selected text range.
    /// - Parameter lastOffsetFromEnd: The last stored selected text range offset from end. Used to keep it concise with pre-formatting.
    func updateSelectedTextRange(lastOffsetFromEnd: Int) {
        /// If text is empty the offset is set to zero, the selected text range does need to be changed.
        if let text = text, text.isEmpty {
            return
        }

        var offsetFromEnd = lastOffsetFromEnd

        /// Adjust offset if needed. When the last number character offset from end is less than the current offset,
        /// or in other words, is more distant to the end of the string, the offset is readjusted to it,
        /// so the selected text range is correctly set to the last index with a number.
        
        if let lastNumberOffsetFromEnd = text?.lastNumberOffsetFromEnd,
            case let shouldOffsetBeAdjusted = lastNumberOffsetFromEnd < offsetFromEnd,
            shouldOffsetBeAdjusted {

            offsetFromEnd = lastNumberOffsetFromEnd
        }

        if let updatedCursorPosition = position(from: endOfDocument, offset: offsetFromEnd) {
            selectedTextRange = textRange(from: updatedCursorPosition, to: updatedCursorPosition)
        }
    }
}
