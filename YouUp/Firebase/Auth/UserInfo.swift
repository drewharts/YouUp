//
//  UserInfo.swift
//  YouUp
//
//  Created by JJ Stephens on 3/22/21.
//

import Foundation
import Firebase

class UserInfo: ObservableObject {
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    enum UpState {
        case up, notup
    }
    @Published var isUserAuthenticated: FBAuthState = .undefined
    @Published var onlineStatus: UpState = .notup
    @Published var user: FBUser = .init(uid: "", name: "", email: "")
    let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .signedIn
//            FBFirestore.retrieveFBUser(uid: user.uid) { (result) in
//                switch result {
//                case .failure(let error):
//                    print(error.localizeDescription)
//                case .success(let user):
//                    self.user = user
//                }
//            }
        })
    }
    
    // Switch online status
    func switchUpStatus() {
        if getUpStatus() {
            setUpStatus(changeToOnline: false)
        } else {
            setUpStatus(changeToOnline: true)
        }
    }
    
    // Set online status
    func setUpStatus(changeToOnline:Bool) {
        if changeToOnline {
            onlineStatus = .up
        } else {
            onlineStatus = .notup
        }
    }
    
    // Return online status as bool
    func getUpStatus() -> Bool {
        if onlineStatus == .up {
            return true;
        } else {
            return false;
        }
    }
    
    // Return online status as a string
    func upStatusString() -> String {
        if getUpStatus() {
            return "Cancel (22) minutes remaining"
        } else {
            return "I'm up"
        }
    }
    
    func getLoggedInStatus() -> String {
        if isUserAuthenticated == .undefined {
            return "Logging you in..."
        } else if isUserAuthenticated == .signedIn {
            return "Logged in as \(user.name)"
        } else {
            return "Logged Out"
        }
    }
}
