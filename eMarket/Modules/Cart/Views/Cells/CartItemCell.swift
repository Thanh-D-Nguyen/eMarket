//
//  CartItemCell.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

protocol CartItemCellDelegate: AnyObject {
    func cartItemCell(_ cell: CartItemCell, didChangeAction action: StepAction)
    func cartItemCellDidDeleteItem(_ cell: CartItemCell)
}

class CartItemCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var stepView: StepView!
    
    var delegate: CartItemCellDelegate?
    private(set) var index: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stepView.layer.cornerRadius = 4
        stepView.layer.masksToBounds = true
        stepView.layer.borderWidth = 1
        stepView.layer.borderColor = UIColor(named: "lineColor")?.cgColor
        priceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .bold)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCartItem(_ item: ProductEntity, index: Int) {
        nameLabel.text = item.name
        priceLabel.text = item.totalPriceText
        productImageView.setImage(from: item.image_url ?? "")
        stepView.value = Int(item.quantity)
        self.index = index
        // For test
        self.accessibilityLabel = "CartItemCell\(index)"
    }
    
    @IBAction
    private func stepViewAction(sender: StepView) {
        delegate?.cartItemCell(self, didChangeAction: sender.action)
    }
    
    @IBAction
    private func cellDeleteAction() {
        delegate?.cartItemCellDidDeleteItem(self)
    }
}
