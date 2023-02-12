//
//  HowToEnableView.swift
//  Phil
//
//  Created by Lau on 12-02-23.
//

import SwiftUI
import VideoPlayer

struct InstructionStep: View {
    let text: String
    let systemImage: String
    let imageColor: Color
    
    var body: some View {
        HStack(spacing: 17.0) {
            Image(systemName: systemImage)
                .font(Font.headline.weight(.semibold))
                .foregroundColor(imageColor)
            Text(.init(text))
        }
    }
}

struct HowToEnableView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 34.0) {
                        VideoPlayer(
                            url: URL(fileURLWithPath: Bundle.main.path(forResource: "HowToVideo", ofType: "mov")!),
                            play: .constant(true)
                        )
                        .autoReplay(true)
                        .mute(true)
                        .frame(width: geometry.size.width - (16.0 * 2))
                        .aspectRatio((4 / 3), contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 16.0 - (1.0 / 2),
                                style: .continuous
                            )
                            .stroke(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.1), lineWidth: 1.0)
                            .padding(1.0 / 2)
                        )
                        .shadow(
                            color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.15),
                            radius: 32,
                            x: 0,
                            y: 4
                        )
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 24.0) {
                                InstructionStep(
                                    text: "Abre la app de **Configuración**",
                                    systemImage: "gear",
                                    imageColor: .gray
                                )
                                InstructionStep(
                                    text: "Selecciona **Safari**",
                                    systemImage: "safari",
                                    imageColor: .blue
                                )
                                InstructionStep(
                                    text: "Selecciona **Extensiones**",
                                    systemImage: "puzzlepiece.extension",
                                    imageColor: .gray
                                )
                                InstructionStep(
                                    text: "Selecciona **Phil**",
                                    systemImage: "p.square",
                                    imageColor: .accentColor
                                )
                                InstructionStep(
                                    text: "Activa **Phil**",
                                    systemImage: "switch.2",
                                    imageColor: .green
                                )
                                InstructionStep(
                                    text: "Selecciona \"transbank.cl\" y luego **Permitir**",
                                    systemImage: "globe",
                                    imageColor: .gray
                                )
                            }
                            .padding(.horizontal, 16.0)
                            
                            Spacer()
                        }
                    }
                    .imageScale(.large)
                    .padding(16.0)
                }
                .navigationTitle("Cómo activar Phil")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            print("hey")
                        }) {
                            Text("Listo")
                        }
                    }
                }
            }
        }
    }
}

struct HowToEnableView_Previews: PreviewProvider {
    static var previews: some View {
        HowToEnableView()
    }
}
