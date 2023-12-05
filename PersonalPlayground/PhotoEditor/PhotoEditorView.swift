//
//  PhotoEditorView.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 21.11.2023.
//

import SwiftUI

struct PhotoEditorView: View {
    @StateObject var pectl: PECtl = PECtl()
    
    var body: some View {
        VStack {            
            ContrastControl()
        }
        .padding(.horizontal)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .ignoresSafeArea()
            
            PhotoEditorView()
        }

    }
}
