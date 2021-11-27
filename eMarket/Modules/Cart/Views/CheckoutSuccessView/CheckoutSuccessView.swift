//
//  CheckoutSuccessView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

protocol CheckoutSuccessViewDelegate: AnyObject {
    func checkoutSuccessViewBack(_ view: CheckoutSuccessView)
}
class CheckoutSuccessView: UIView {

    weak var delegate: CheckoutSuccessViewDelegate?
    
    @IBOutlet private weak var backHomeButton: UIButton!

    private func setupView() {
        instantiate()
        backHomeButton.layer.cornerRadius = 4
        backHomeButton.layer.masksToBounds = true
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
    private func back() {
        delegate?.checkoutSuccessViewBack(self)
    }
}
extension CheckoutSuccessView: NibInstantiate { }
