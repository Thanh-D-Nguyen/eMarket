//
//  StoreInforView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import UIKit

class StoreInforView: UIView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var openTimeLabel: UILabel!
    @IBOutlet private weak var closingTimeLabel: UILabel!
    @IBOutlet private weak var storeImageView: UIImageView!
    private func setupView() {
        instantiate()
        nameLabel.text = ""
        rateLabel.text = ""
        openTimeLabel.text = ""
        closingTimeLabel.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        storeImageView.layer.cornerRadius = storeImageView.bounds.height / 2
        storeImageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func updateInformation(_ store: Store) {
        nameLabel.text = store.name
        rateLabel.text = "\(store.rating)"
        openTimeLabel.text = store.formatedOpenTime
        closingTimeLabel.text = store.formatedClosingTime
    }
}

extension StoreInforView: NibInstantiate {}
