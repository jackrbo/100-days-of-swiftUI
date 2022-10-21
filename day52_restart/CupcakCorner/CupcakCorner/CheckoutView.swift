//
//  CheckoutView.swift
//  CupcakCorner
//
//  Created by Richard-Bollans, Jack on 7.10.2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderClass: OrderClass
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var orderFailed = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) {
                image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Button("Place order") {
                Task {
                    await placeOrder()
                }
            }
                .padding()
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Order failed", isPresented: $orderFailed) {
            Button("OK") { }
        } message: {
            Text("Please try again")
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderClass.order) else {
            print("Failed")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoder = JSONDecoder()
            let decodedOrder = try decoder.decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cakes is on its way"
            showingConfirmation = true
        } catch {
            orderFailed = true
            print("Checkout failed")
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(orderClass: OrderClass())
        }
    }
}
