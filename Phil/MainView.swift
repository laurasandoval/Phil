//
//  MainView.swift
//  Phil
//
//  Created by Lau on 12-02-23.
//

import SwiftUI

struct MainView: View {
    @State private var showingHowToEnableView: Bool = false
    
    var body: some View {
        Text("Hey")
            .onAppear {
                self.showingHowToEnableView = true
            }
            .sheet(isPresented: $showingHowToEnableView) {
                HowToEnableView()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
