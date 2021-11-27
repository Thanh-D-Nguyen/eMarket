//
//  CartSummaryView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

protocol CartSummaryViewDelegate: AnyObject {
    func cartSummaryViewDidCheckout(_ view: CartSummaryView)
}

class CartSummaryView: UIView {
    @IBOutlet weak private var checkoutButton: UIButton!
    @IBOutlet weak private var totalPriceLabel: UILabel!
    weak var delegate: CartSummaryViewDelegate?
    
    private func setupView() {
        instantiate()
        checkoutButton.layer.cornerRadius = 6.0
        checkoutButton.layer.masksToBounds = true
        totalPriceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .bold)
        
        // For test
        checkoutButton.accessibilityLabel = "Checkout"
        totalPriceLabel.accessibilityLabel = "TotalPriceLabel"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func updateSumammry(_ summary: CartSummaryItem) {
        checkoutButton.setTitle(summary.checkoutText, for: .normal)
        totalPriceLabel.text = summary.totalPriceText
    }
    
    @IBAction
    private func checkoutAction() {
        delegate?.cartSummaryViewDidCheckout(self)
    }
}

extension CartSummaryView: NibInstantiate {}
