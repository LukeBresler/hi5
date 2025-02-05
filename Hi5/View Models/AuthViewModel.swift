//
//  AuthViewModel.swift
//  Hi5
//
//  Created by Luke Bresler on 2024/09/26.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isUserLoggedIn = Auth.auth().currentUser != nil
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        // Store the handle to the state change listener
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isUserLoggedIn = user != nil
        }
    }
    
    deinit {
        // Remove the listener when the view model is deallocated
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
