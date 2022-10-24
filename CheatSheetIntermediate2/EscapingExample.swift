//
//  EscapingExample.swift
//  CheatSheetIntermediate2
//
//  Created by Zachary on 24/10/22.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
//    func getData() {
//        downloadData3 { [weak self] returnedData in
//            self?.text = returnedData
//        }
    
    func getData() {
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data2
            self?.text = returnedResult.data
        }

    }
    
    func downloadData() -> String {
        return "New data!"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> () ) {
        completionHandler("New data!")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> () ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New data!")

        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> () ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let result = DownloadResult(data: "New data!", data2: "2nd new data!")
            
            completionHandler(result)

        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let result = DownloadResult(data: "New data!", data2: "2nd new data!")
            
            completionHandler(result)

        }
    }
    
}

struct DownloadResult {
    let data: String
    let data2: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingExample: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingExample_Previews: PreviewProvider {
    static var previews: some View {
        EscapingExample()
    }
}
