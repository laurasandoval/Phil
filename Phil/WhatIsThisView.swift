//
//  WhatIsThisView.swift
//  Phil
//
//  Created by Lau on 12-02-23.
//

import SwiftUI

struct WhatIsThisView: View {
    
    let text = """
    **Phil** es una pequeña extensión de Safari que te permite autorrellenar tus tarjetas de crédito o débito guardadas en Safari cuando estés comprando a través de Webpay.
    
    El autorrelleno de tarjetas es una práctica estándar en la industria de métodos de pago, pero por alguna razón Webpay nunca la ha adoptado. Esta extensión arregla eso.
    
    Para usar Phil, primero tienes que tener alguna tarjeta guardada en Safari. Puedes ver tus tarjetas guardadas abriendo la app de **Configuración**, y luego seleccionando **Safari** → **Autorrelleno**.
    
    **Phil no recopila ningún tipo de información sobre ti o tus tarjetas**. Puedes comprobar esto tú misma o tú mismo [viendo el código de Phil en GitHub](https://github.com/laurasandoval/Phil).
    
    **¿Por qué Phil?** Porque suena como "AutoFill", que es "Autorrelleno" en inglés. Eso y porque el fin de semana que hice esta app estuve viendo Modern Family y me acordé de [Phil Dunphy](https://www.google.com/search?q=Phil+Dunphy).
    """
    
    var body: some View {
        List {
            Section {
                Text(.init(text))
            } footer: {
                Text("Phil no está asociado a Transbank o Webpay en ningúna forma, tamaño o color. Phil es una aplicación independiente creada por Laura Sandoval")
            }
        }
        .navigationTitle("Qué es esto")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct WhatIsThisView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WhatIsThisView()
        }
    }
}

extension AttributedString {
    init(styledMarkdown markdownString: String) throws {
        var output = try AttributedString(
            markdown: markdownString,
            options: .init(
                allowsExtendedAttributes: true,
                interpretedSyntax: .full,
                failurePolicy: .returnPartiallyParsedIfPossible
            ),
            baseURL: nil
        )
        
        for (intentBlock, intentRange) in output.runs[AttributeScopes.FoundationAttributes.PresentationIntentAttribute.self].reversed() {
            guard let intentBlock = intentBlock else { continue }
            for intent in intentBlock.components {
                switch intent.kind {
                case .header(level: let level):
                    switch level {
                    case 1:
                        output[intentRange].font = .system(.title).bold()
                    case 2:
                        output[intentRange].font = .system(.title2).bold()
                    case 3:
                        output[intentRange].font = .system(.title3).bold()
                    default:
                        break
                    }
                default:
                    break
                }
            }
            
            if intentRange.lowerBound != output.startIndex {
                output.characters.insert(contentsOf: "\n", at: intentRange.lowerBound)
            }
        }
        
        self = output
    }
}
