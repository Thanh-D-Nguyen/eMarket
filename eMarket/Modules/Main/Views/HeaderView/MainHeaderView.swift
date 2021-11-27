//
//  HeaderView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import UIKit

protocol MainHeaderViewDelegate: AnyObject {
    func mainHeaderViewDidTapCart(_ view: MainHeaderView)
}

class MainHeaderView: UIView {
    
    @IBOutlet weak private var productCountLabel: UILabel!
    @IBOutlet weak private var addToCartButton: UIButton!
    
    weak var delegate: MainHeaderViewDelegate?
    
    private func setupView() {
        instantiate()
        productCountLabel.isHidden = true
        // for test
        addToCartButton.accessibilityLabel = "ShowYourCart"
        productCountLabel.accessibilityLabel = "ProductCountLabel"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productCountLabel.layer.cornerRadius = productCountLabel.bounds.width / 2
        productCountLabel.layer.masksToBounds = true
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
    private func gotoCartAction() {
        delegate?.mainHeaderViewDidTapCart(self)
    }
    
    func updateNumOfProductInCart(_ count: Int, animated: Bool) {
        productCountLabel.isHidden = count == 0
        
        productCountLabel.accessibilityLabel = count == 0 ? "ProductCountLabelHidden" : "ProductCountLabel"

        self.productCountLabel.text = "\(count)"

        if animated == true {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                self.productCountLabel.bounds.size.height += 10.0
                self.productCountLabel.bounds.size.width += 10.0
            }) { _ in
                self.productCountLabel.bounds.size.height -= 10.0
                self.productCountLabel.bounds.size.width -= 10.0
            }
        }
    }
}
extension MainHeaderView: NibInstantiate {}
