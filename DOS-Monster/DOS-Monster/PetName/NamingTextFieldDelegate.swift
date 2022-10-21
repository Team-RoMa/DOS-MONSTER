//
//  NamingTextFieldDelegate.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/12.
//

import UIKit

class NamingTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
