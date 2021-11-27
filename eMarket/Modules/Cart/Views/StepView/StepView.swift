//
//  StepView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

enum StepAction {
    case plus, sub, none
}

class StepView: UIControl {
    private(set) var action: StepAction = .none
    @IBOutlet weak private var valueButton: UIButton!
    
    var value: Int = 0 {
        didSet {
            valueButton.setTitle("\(value)", for: .normal)
        }
    }
    
    private func setupView() {
        instantiate()
        valueButton.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .regular)
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
    private func plusAction() {
        action = .plus
        sendActions(for: .touchUpInside)
    }

    @IBAction
    private func subAction() {
        action = .sub
        sendActions(for: .touchUpInside)
    }
}

extension StepView: NibInstantiate {}
