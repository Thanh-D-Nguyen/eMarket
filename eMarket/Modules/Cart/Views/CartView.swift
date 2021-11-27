//
//  CartView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

protocol CartViewProtocol: AnyObject {
    func didLoadCartInformation()
}

class CartView: UIViewController {
    @IBOutlet weak private var cartTableView: UITableView!
    @IBOutlet weak private var noProductView: UIView!
    @IBOutlet weak private var summaryView: CartSummaryView!
    
    var presenter: CartPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        summaryView.delegate = self
        cartTableView.registerNib(cellClass: AddressCell.self)
        cartTableView.registerNib(cellClass: CartItemCell.self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @IBAction
    private func close() {
        presenter.dismiss()
    }
}

extension CartView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CartTableSection.numOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == CartTableSection.address.rawValue {
            let cell: AddressCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
            cell.updateDeliveryAddress(presenter.deliveryAddress)
            return cell
        }
        let cell: CartItemCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.updateCartItem(presenter.cartItemAt(indexPath.row), index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == CartTableSection.address.rawValue {
            return UITableView.automaticDimension
        }
        return 120.0
    }
}

extension CartView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == CartTableSection.address.rawValue {
            presenter.showEditAddress()
        }
    }
}

extension CartView: CartItemCellDelegate {
    func cartItemCell(_ cell: CartItemCell, didChangeAction action: StepAction) {
        presenter.updateCartItemQuantityIndex(cell.index, changeAction: action)
    }
    
    func cartItemCellDidDeleteItem(_ cell: CartItemCell) {
        presenter.deleteCartAtIndex(cell.index)
    }
}

extension CartView: CartViewProtocol {
    func didLoadCartInformation() {
        noProductView.isHidden = presenter.numOfRowInSection(CartTableSection.item.rawValue) != 0
        cartTableView.reloadData()
        summaryView.updateSumammry(presenter.summaryItem)
    }
}

extension CartView: CartSummaryViewDelegate {
    func cartSummaryViewDidCheckout(_ view: CartSummaryView) {
        presenter.processCheckout()
    }
}

extension CartView: CheckoutSuccessViewDelegate {
    func checkoutSuccessViewBack(_ view: CheckoutSuccessView) {
        presenter.dismiss()
    }
}
