//
//  ProductsListViewModel.swift
//  Store
//
//  Created by Baramidze on 25.11.23.
//

import Foundation

protocol ProductsListViewModelDelegate: AnyObject {
    func productsFetched()
    func productsAmountChanged()
    func showErrorAlert(message: String)
    //added a method to be able to show an error later
}

class ProductsListViewModel {

    weak var delegate: ProductsListViewModelDelegate?
    var products: [ProductModel]?
    var totalPrice: Double? { products?.reduce(0) { $0 + $1.price * Double(($1.selectedAmount ?? 0))} }
    
    func viewDidLoad() {
        fetchProducts()
    }
    
    private func fetchProducts() {
        NetworkManager.shared.fetchProducts { [weak self] response in
            switch response {
            case .success(let products):
                self?.products = products
                DispatchQueue.main.async {
                    self?.delegate?.productsFetched()
                }
            case .failure(let error):
                // TODO: Handle error - added
                print("Error fetching products: \(error)")
                DispatchQueue.main.async {
                    self?.delegate?.showErrorAlert(message: "Failed to fetch products. Please try again later.")
                }
            }
        }
    }

    
    func addProduct(at index: Int) {
        guard var product = products?[index] else { return }

        // TODO: Handle if products are out of stock - done
        if product.stock > 0 {
            product.selectedAmount = (product.selectedAmount ?? 0) + 1
            product.stock -= 1
            products?[index] = product
            delegate?.productsAmountChanged()
        } else {
            // TODO: Handle out-of-stock scenario - done
            delegate?.showErrorAlert(message: "This product is currently out of stock.")
        }
    }

    func removeProduct(at index: Int) {
        guard var product = products?[index] else { return }

        // TODO: Handle if selected quantity of the product is already 0 - done
        if let selectedAmount = product.selectedAmount, selectedAmount > 0 {
            product.selectedAmount = selectedAmount - 1
            product.stock += 1
            products?[index] = product
            delegate?.productsAmountChanged()
        } else {
            // TODO: Handle the case where the selected quantity is already 0 - done
            delegate?.showErrorAlert(message: "You cannot remove more of this product as the quantity is already 0.")
        }
    }

}


