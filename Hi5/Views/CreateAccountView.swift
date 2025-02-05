//
//  CreateAccountView.swift
//  Hi5
//
//  Created by Luke Bresler on 2024/09/26.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                createAccount()
            }) {
                Text("Create Account")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Text(errorMessage)
                .foregroundColor(.red)
        }
        .padding()
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:
                    errorMessage = "The email is already in use."
                case .invalidEmail:
                    errorMessage = "Please enter a valid email."
                case .weakPassword:
                    errorMessage = "The password is too weak."
                default:
                    errorMessage = error.localizedDescription
                }
                return
            }
            errorMessage = "Account created successfully!"
            authViewModel.isUserLoggedIn = true // Update login state
        }
    }
}

#Preview {
    CreateAccountView(authViewModel: AuthViewModel())
}
