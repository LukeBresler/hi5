//
//  DeleteAccountView.swift
//  Hi5
//
//  Created by Luke Bresler on 2024/09/26.
//

import SwiftUI
import FirebaseAuth

struct DeleteAccountView: View {
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            Text("Delete Account")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            Button(action: {
                deleteAccount()
            }) {
                Text("Delete Account")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Text(errorMessage)
                .foregroundColor(.red)
        }
        .padding()
    }
    
    func deleteAccount() {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    errorMessage = error.localizedDescription
                    return
                }
                errorMessage = "Account deleted successfully!"
            }
        }
    }
}

#Preview {
    DeleteAccountView()
}

