//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Richard-Bollans, Jack on 28.9.2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupckes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is \(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else {
                print("No data response:\(error?.localizedDescription ?? "Unknown error"). ")
                return
            }
            let decoder = JSONDecoder()
            guard let decodedOrder = try? decoder.decode(Order.self, from: data) else {
                print("Couldn't decode data")
                return
            }
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way! To  \(decodedOrder.name) at address \(decodedOrder.streetAddress), \(decodedOrder.city), \(decodedOrder.zip)"
            showingConfirmation = true
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
