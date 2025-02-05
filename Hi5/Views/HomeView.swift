//
//  HomeView.swift
//  Hi5
//
//  Created by Luke Bresler on 2024/09/26.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Welcome to")
            Text("Hi5")
                .font(.largeTitle)
            
            Button(action: {
                logout()
            }) {
                Text("Logout")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    func logout() {
        authViewModel.signOut()
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
