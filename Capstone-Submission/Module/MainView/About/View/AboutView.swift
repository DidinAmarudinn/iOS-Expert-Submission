//
//  AboutView.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 04/03/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("About")
                .font(.title)
                .padding(.vertical, 16)
            
            Image("profil")
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(6)
                .scaledToFill()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Didin Amarudin")
                Text("amardidin53@gmail.com")
                    .tint(.white)
                Text("iOS and Flutter Developer")
            }
            HStack {
                Spacer()
            }
            Spacer()
        }.padding(16)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
