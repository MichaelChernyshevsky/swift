import SwiftUI

class EconomyViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func addTransaction(title: String, amount: Double, isIncome: Bool) {
        let newTransaction = Transaction(title: title, amount: amount, isIncome: isIncome)
        transactions.append(newTransaction)
    }
    
    var totalBalance: Double {
        transactions.reduce(0) { $0 + ($1.isIncome ? $1.amount : -$1.amount) }
    }
}
