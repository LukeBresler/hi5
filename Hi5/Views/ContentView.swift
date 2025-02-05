//
//  ContentView.swift
//  Hi5
//
//  Created by Luke Bresler on 2024/09/26.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            if authViewModel.isUserLoggedIn {
                HomeView()
                    .environmentObject(authViewModel)
            } else {
                VStack {
                    NavigationLink(destination: CreateAccountView(authViewModel: authViewModel)) {
                        Text("Create Account")
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: LoginView(authViewModel: authViewModel)) {
                        Text("Login")
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

