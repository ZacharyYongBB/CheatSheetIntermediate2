//
//  DownloadWithCombineExample.swift
//  CheatSheetIntermediate2
//
//  Created by Zachary on 26/10/22.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
}

struct DownloadWithCombineExample: View {
    
    @State var vm = DownloadWithEscapingExample()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DownloadWithCombineExample_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineExample()
    }
}
