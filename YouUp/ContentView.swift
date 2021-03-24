//
//  ContentView.swift
//  YouUp
//
//  Created by Andrew Hartsfield and JJ Stephens on 3/2/21.
//

import SwiftUI

struct ContentView: View {
    //var onlineIndicator = OnlineIndicator()
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading...")
            } else if userInfo.isUserAuthenticated == .signedOut {
                LoginView()
            } else {
                HomeView()
            }
        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
