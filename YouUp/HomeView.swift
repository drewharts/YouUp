//
//  HomeView.swift
//  YouUp
//
//  Created by Andrew Hartsfield and JJ Stephens on 3/22/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        NavigationView {
            VStack{
                ScrollView{
                    // Contacts here
                }
                Spacer()
                Button(userInfo.upStatusString()) {
                    userInfo.switchUpStatus()
                }
                .frame(maxWidth: .infinity) // makes button take up screen from side to side
                .padding()
                .accentColor(Color.white)
                .background(userInfo.getUpStatus() ? Color.red : Color.green)
            }
            .frame(maxHeight: .infinity)
            //Set up NavigationView
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
