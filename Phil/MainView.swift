//
//  MainView.swift
//  Phil
//
//  Created by Lau on 12-02-23.
//

import SwiftUI

struct Cell: View {
    let iconSystemName: String
    let iconBackgroundColor: Color
    let text: String
    var chevron: Bool? = false
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "app.fill")
                    .font(.system(size: 32.0))
                    .foregroundColor(iconBackgroundColor)
                Image(systemName: iconSystemName)
                    .font(.system(size: 16.0))
                    .foregroundColor(.white)
            }
            .accessibilityHidden(true)
            
            Text(text)
                .foregroundColor(.primary)
            
            if chevron ?? false {
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(uiColor: .tertiaryLabel))
                    .padding(.trailing, 4.0)
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding(.horizontal)
    }
}

struct MainView: View {
    @AppStorage("shouldOnboardUser") var shouldOnboardUser: Bool = true
    @State private var showingHowToEnableView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button(action: {
                        self.showingHowToEnableView = true
                    }) {
                        Cell(
                            iconSystemName: "sparkles",
                            iconBackgroundColor: .accentColor,
                            text: "Cómo activar Phil",
                            chevron: true
                        )
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0.0))
                    
                    NavigationLink(destination: WhatIsThisView()) {
                        Cell(
                            iconSystemName: "info.circle.fill",
                            iconBackgroundColor: .gray,
                            text: "Qué es esto"
                        )
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 21.0))
                }
                Section {
                    Link(destination: URL(string: "https://github.com/laurasandoval/Phil")!) {
                        Cell(
                            iconSystemName: "curlybraces",
                            iconBackgroundColor: .blue,
                            text: "Código fuente",
                            chevron: true
                        )
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Link(destination: URL(string: "https://lau.work/phil/politica-de-privacidad")!) {
                        Cell(
                            iconSystemName: "hand.raised.fill",
                            iconBackgroundColor: .gray,
                            text: "Política de privacidad",
                            chevron: true
                        )
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                Section {
                    Link(destination: URL(string: "https://lau.work")!) {
                        Cell(
                            iconSystemName: "heart.fill",
                            iconBackgroundColor: .red,
                            text: "Califica Phil en el App Store",
                            chevron: true
                        )
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                Section {
                    Link(destination: URL(string: "https://lau.work")!) {
                        Cell(
                            iconSystemName: "l.square.fill",
                            iconBackgroundColor: .black,
                            text: "Laura Sandoval",
                            chevron: true
                        )
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                } header: {
                    Text("Sobre la desarrolladora")
                }
            }
            .navigationTitle("Phil")
        }
        .onAppear {
            if self.shouldOnboardUser {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showingHowToEnableView = true
                    self.shouldOnboardUser = false
                }
            }
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
