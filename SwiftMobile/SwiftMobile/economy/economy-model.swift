//
//  model.swift
//  SwiftMobile
//
//  Created by Mihail_Ch on 13.08.2024.
//

import Foundation


struct Transaction: Identifiable {
    var id = UUID()
    var title: String
    var amount: Double
    var isIncome: Bool
}
