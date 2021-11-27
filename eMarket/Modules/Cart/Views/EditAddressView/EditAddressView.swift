//
//  EditAddressView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/28.
//

import UIKit

class EditAddressView: UIView {
    var completionHandler: ((String) -> Void)?
    
    @IBOutlet private weak var addressTextField: UITextField!

    private func setupView() {
        instantiate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    @IBAction
    private func changeAddressAction() {
        completionHandler?(addressTextField.text ?? "")
        addressTextField.resignFirstResponder()
        removeFromSuperview()
    }
    
    @IBAction
    private func cancelAction() {
        addressTextField.resignFirstResponder()
        removeFromSuperview()
    }
    
    func startKeyboard() {
        addressTextField.becomeFirstResponder()
    }

}
extension EditAddressView: NibInstantiate {}
