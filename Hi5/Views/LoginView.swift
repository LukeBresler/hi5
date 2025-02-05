//
//  LoginView.swift
//  Hi5
//
//  Created by Luke Bresler on 2024/09/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
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
                login()
            }) {
                Text("Login")
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
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .networkError:
                    errorMessage = "Network error. Please try again."
                case .userNotFound:
                    errorMessage = "User not found. Please register."
                case .wrongPassword:
                    errorMessage = "Incorrect password."
                default:
                    errorMessage = error.localizedDescription
                }
                return
            }
            errorMessage = "Logged in successfully!"
            authViewModel.isUserLoggedIn = true // Update login state
        }
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}
