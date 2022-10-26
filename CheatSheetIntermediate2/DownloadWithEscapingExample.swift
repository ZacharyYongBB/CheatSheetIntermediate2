//
//  DownloadWithEscapingExample.swift
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

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error Downloading Data.")
                return
            }
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response.")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx, but is \(response.statusCode)")
                return
            }
            
            
            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.posts.append(newPost)
            }
            
            
            
        }.resume()
    }
    
}

struct DownloadWithEscapingExample: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscapingExample_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingExample()
    }
}
