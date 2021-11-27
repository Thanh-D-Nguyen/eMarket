//
//  MainView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/25.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func didLoadStore(_ store: Store?)
    func didLoadProducts()
    
    func didUpdateNumOfProductInCart(_ count: Int, animated: Bool)
    func didShowNoticeProductExistInCart()
}

class MainView: UIViewController {
    
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    @IBOutlet private weak var storeInforView: StoreInforView!
    @IBOutlet private weak var mainHeaderView: MainHeaderView!
    @IBOutlet private weak var productExistLabel: UILabel!
    
    var presenter: MainPresenterProtocol!
    
    private func prepareView() {
        mainHeaderView.delegate = self
        productsCollectionView.register(cellClass: ProductItemCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        productsCollectionView.setCollectionViewLayout(layout, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.productsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductItemCell = collectionView.dequeueResuableCell(forIndexPath: indexPath)
        cell.updateProduct(presenter.product(at: indexPath.row), cellIndex: indexPath.row)
        cell.delegate = self
        return cell
    }
    
}
extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = collectionView.frame.width / 2 - layout.minimumInteritemSpacing * 2
        return CGSize(width: width, height: width * 1.55)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
}

extension MainView: UICollectionViewDelegate {
    
}

extension MainView: MainViewProtocol {
    func didShowNoticeProductExistInCart() {
        self.productExistLabel.alpha = 1.0
        UIView.animate(withDuration: 1.5) {
            self.productExistLabel.alpha = 0.8
        } completion: { _ in
            self.productExistLabel.alpha = 0.0
        }

    }
    
    func didLoadStore(_ store: Store?) {
        if let store = store {
            storeInforView.updateInformation(store)
        }
    }
    
    func didLoadProducts() {
        productsCollectionView.reloadData()
    }
    
    func didUpdateNumOfProductInCart(_ count: Int, animated: Bool) {
        mainHeaderView.updateNumOfProductInCart(count, animated: animated)
    }
}

extension MainView: ProductItemCellDelegate {
    func productItemCellDidAddToCart(_ cell: ProductItemCell, atIndex index: Int) {
        presenter.addProductToCart(atIndex: index)
    }
}

extension MainView: MainHeaderViewDelegate {
    func mainHeaderViewDidTapCart(_ view: MainHeaderView) {
        presenter.showCartView()
    }
}
