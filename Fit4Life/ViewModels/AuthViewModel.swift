//
//  AuthViewModel.swift
//  Fit4Life
//
//  Created by Styles Weiler on 1/21/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor // publish changes to the main thread
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? // firebase user object
    @Published var currentUser: User? // data model
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email,
                                                      password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser() // fetch the data we just created in Firebase so we can display it to the user
            
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out the user on the backend
            self.currentUser = nil // wipe out user sessiona and takes the user back to the login screen
            self.userSession = nil // wipes out current user data model
            
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            
        }
    }
    
    func deleteAccount() {
        func deleteAccount(userId: String) async {
            do {
                // Attempt to delete user data from Firestore
                try await Firestore.firestore().collection("users").document(userId).delete()
                print("DEBUG: Successfully deleted mock user data from Firestore.")
                
            } catch {
                print("DEBUG: Failed to delete mock user data with error \(error.localizedDescription).")
            }
        }

    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
