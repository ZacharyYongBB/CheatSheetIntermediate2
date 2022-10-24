//
//  TypealiasExample.swift
//  CheatSheetIntermediate2
//
//  Created by Zachary on 24/10/22.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasExample: View {
    
    @State var movieItem: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    @State var tvItem: TVModel = TVModel(title: "Another Title", director: "Sam", count: 10)
    
    var body: some View {
        VStack {
            Text(tvItem.title)
            Text(tvItem.director)
            Text("\(tvItem.count)")
        }
    }
}

struct TypealiasExample_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasExample()
    }
}
