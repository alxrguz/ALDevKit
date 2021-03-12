//
//  ALCurrencyTextFieldDelegate.swift
//  Finance
//
//  Created by Alexandr Guzenko on 06.11.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

public class ALDecimalTextFieldDelegate: NSObject {
    public var maximumFractionDigits: Int {
        set { formatter.maximumFractionDigits = newValue }
        get { formatter.maximumFractionDigits }
    }
    
    public var locale: Locale {
        set { formatter.locale = newValue }
        get { formatter.locale }
    }
    
    public var currencyDecimalSeparator: String {
        set { formatter.currencyDecimalSeparator = newValue }
        get { formatter.currencyDecimalSeparator }
    }
    
    public var decimalSeparator: String {
        set { formatter.decimalSeparator = newValue }
        get { formatter.decimalSeparator }
    }
    
    public var currencyGroupingSeparator: String {
        set { formatter.currencyGroupingSeparator = newValue }
        get { formatter.currencyGroupingSeparator }
    }
    
    public var groupingSeparator: String {
        set { formatter.groupingSeparator = newValue }
        get { formatter.groupingSeparator }
    }
    
    public var currencySymbol: String {
        set { formatter.currencySymbol = newValue }
        get { formatter.currencySymbol }
    }
    
    public func setValue(_ value: Double, to textField: UITextField) {
        textField.text = formatter.string(for: value)?.trim
    }
    
    public func setPlaceholder(_ value: Double, to textField: UITextField) {
        textField.placeholder = formatter.string(for: value)?.trim
    }
    
    public func getValue(from textField: UITextField) -> Double? {
        convertToValue(from: textField.text ?? "")
    }
    
    public var maximumValue: Double?
    
    private var lastSymbol = ""
    private var formatter: NumberFormatter = {
        $0.numberStyle = .currency
        $0.minimumFractionDigits = 0
        $0.maximumFractionDigits = 2
        return $0
    }(NumberFormatter())
    
    private var separatorPattern: String {
        "[\(decimalSeparator)]"
    }
    
    private var numberPattern: String {
        "[0-9]{1,}(\\.[0-9]{1,\(maximumFractionDigits)})?"
    }
}

extension ALDecimalTextFieldDelegate: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setInitialSelectedTextRange()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let isSeparator = string.regex(pattern: separatorPattern).isEmpty == false
        if isSeparator {
            lastSymbol = string
            let isSingleSeparator = textField.text?.regex(pattern: separatorPattern).count ?? 0 == 0
            return isSingleSeparator
        }
        
        let oldString = textField.text ?? ""
        let newString = NSString(string: oldString).replacingCharacters(in: range, with: string)
        var position = textField.selectedTextRangeOffsetFromEnd
        
        defer {
            lastSymbol = string
            textField.updateSelectedTextRange(lastOffsetFromEnd: position)
        }
        
        guard string.isEmpty == false else {
            formatter.minimumFractionDigits = 0
            if let textRange = Range(range, in: oldString),
               oldString[textRange] == formatter.groupingSeparator {
                position -= 1
            }
            handleDeletion(in: textField, at: range)
            return false
        }
        
        if lastSymbol == decimalSeparator, string == "0" {
            formatter.minimumFractionDigits = 1
        } else {
            formatter.minimumFractionDigits = 0
        }
       
        textField.text = formattedCurency(from: newString)
        return false
    }
    
    private func handleDeletion(in textField: UITextField, at range: NSRange) {
        guard var text = textField.text else { return }
        if let textRange = Range(range, in: text) {
            text.removeSubrange(textRange)
        } else {
            text.removeLast()
        }
        
        if text.isEmpty {
            textField.text = text
        } else {
            textField.text = formattedCurency(from: text)
        }
    }
    
    private func formattedCurency(from string: String) -> String? {
        guard let newValue = convertToValue(from: string) else {
            return nil
        }
        
        if let maximum = maximumValue, newValue > maximum {
            return formatter.string(for: maximum)
        }
        
        return formatter.string(for: newValue)?.trim
    }
    
    private func convertToValue(from string: String) -> Double? {
        guard let newValueString = string
            .regex(pattern: "[0-9\(decimalSeparator)]").joined()
            .replacingOccurrences(of: ",", with: ".")
            .regex(pattern: "^" + numberPattern).first else {
            return nil
        }
        
        return NSString(string: newValueString).doubleValue
    }
}
