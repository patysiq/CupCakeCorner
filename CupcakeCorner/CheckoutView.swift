//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by PATRICIA S SIQUEIRA on 20/02/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var classyOrder : ClassyOrder
    @State private var confirmationMessage = ""
    @State private var showingAlert = false
    @State private var showingInetAlert = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is \(self.classyOrder.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                        // day 52 - challenge 2
                        .alert(isPresented: self.$showingInetAlert) {
                            Alert(title: Text("Problem!"), message: Text("There was a problem submitting your order. Please try again later."), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .navigationBarTitle("Check Out", displayMode: .inline)
            .alert(isPresented: self.$showingAlert) {
                Alert(title: Text("Thank you!"), message: Text(self.confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func placeOrder () {
        let urlString = "https://reqres.in/api/cupcakes"
        guard let encoded = try? JSONEncoder().encode(classyOrder.order) else {
            print("failed to encode order")
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response \(error?.localizedDescription ?? "Unknown error")")
                self.showingInetAlert = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "You order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes was received!"
                self.showingAlert = true
            } else {
                print("Invalid response from server")
                self.showingInetAlert = true
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(classyOrder: ClassyOrder())
    }
}
