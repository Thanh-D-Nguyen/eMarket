//
//  ProductItemCell.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit
protocol ProductItemCellDelegate: AnyObject {
    func productItemCellDidAddToCart(_ cell: ProductItemCell, atIndex index: Int)
}

class ProductItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var addToCartButton: UIButton!
    
    weak var delegate: ProductItemCellDelegate?
    
    private var cellIndex: Int = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addToCartButton.layer.cornerRadius = 3.0
        addToCartButton.layer.masksToBounds = true
    }

    func updateProduct(_ product: Product, cellIndex: Int) {
        self.cellIndex = cellIndex
        nameLabel.text = product.name
        priceLabel.text = product.priceText
        productImageView.setImage(from: product.imageURL)
        
        // For Test
        self.accessibilityLabel = "ProductItemCell\(cellIndex)"
    }
    
    @IBAction
    private func actionAddToCard() {
        delegate?.productItemCellDidAddToCart(self, atIndex: cellIndex)
    }
}
