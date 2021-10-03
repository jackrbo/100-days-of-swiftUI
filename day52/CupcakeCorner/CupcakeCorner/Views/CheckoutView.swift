//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Richard-Bollans, Jack on 28.9.2021.
//

import SwiftUI

enum ActiveAlert {
    case confirmation, error
}

struct CheckoutView: View {
    @ObservedObject var model: OrderModel
    
    
    @State private var confirmationMessage = ""
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .error
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupckes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is \(self.model.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            
            switch activeAlert {
            case .confirmation:
                return Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            case .error:
                return Alert(title: Text("Error sending request"), message: Text("There was an issue sending your order. Please check your network connection and try again"), dismissButton: .default(Text("OK")))
            }
        }
        
        
    }
    
    func placeOrder() {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(model.order) else {
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
            if error != nil {
                showAlert = true
                activeAlert = .error
                return
            }
            
            guard let data = data else {
                print("No data response:\(error?.localizedDescription ?? "Unknown error"). ")
                showAlert = true
                activeAlert = .error
                return
            }
            let decoder = JSONDecoder()
            guard let decodedOrder = try? decoder.decode(Order.self, from: data) else {
                print("Couldn't decode data")
                return
            }
            DispatchQueue.main.async {
                confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way! To  \(decodedOrder.name) at address \(decodedOrder.streetAddress), \(decodedOrder.city), \(decodedOrder.zip)"
                showAlert = true
                activeAlert = .confirmation
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(model: OrderModel())
        }
    }
}
