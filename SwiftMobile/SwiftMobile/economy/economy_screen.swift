import SwiftUI

struct EconomyView: View {
    @StateObject private var viewModel = EconomyViewModel()
    @State private var title = ""
    @State private var amount = ""
    @State private var isIncome = true
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Total Balance: \(viewModel.totalBalance, specifier: "%.2f")")
                    .font(.largeTitle)
                    .padding()
                
                Form {
                    Section(header: Text("Add Transaction")) {
                        TextField("Title", text: $title)
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                        
                        Picker("Type", selection: $isIncome) {
                            Text("Income").tag(true)
                            Text("Expense").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button(action: {
                            if let amountValue = Double(amount) {
                                viewModel.addTransaction(title: title, amount: amountValue, isIncome: isIncome)
                                title = ""
                                amount = ""
                            }
                        }) {
                            Text("Add Transaction")
                        }
                    }
                    
                    Section(header: Text("Transactions")) {
                        List(viewModel.transactions) { transaction in
                            HStack {
                                Text(transaction.title)
                                Spacer()
                                Text("\(transaction.amount, specifier: "%.2f")")
                                    .foregroundColor(transaction.isIncome ? .green : .red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Economy")
        }
    }
}

struct EconomyView_Previews: PreviewProvider {
    static var previews: some View {
        EconomyView()
    }
}
