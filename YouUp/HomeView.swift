//
//  HomeView.swift
//  YouUp
//
//  Created by JJ Stephens on 3/22/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        NavigationView {
            Text("Logged in as \(userInfo.user.name)")
                .navigationBarTitle("You Up?")
                .navigationBarItems(trailing: Button("Log Out") {
                    FBAuth.logout { (result) in
                        print("Logged out")
                    }
                })
                .onAppear {
                    guard let uid = Auth.auth().currentUser?.uid else {
                        return
                    }
                    FBFirestore.retrieveFBUser(uid: uid) { (result) in
                        switch result {
                        case .failure( _):
                            print("error.localizeDescription")
                            // Display some kind of alert
                        case .success(let user):
                            self.userInfo.user = user
                        }
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
