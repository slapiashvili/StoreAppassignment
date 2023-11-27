//
//  ProductModel.swift
//  Store
//
//  Created by Baramidze on 25.11.23.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    var stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    var selectedAmount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case discountPercentage
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case images
    }
    //added CodingKeys
}


