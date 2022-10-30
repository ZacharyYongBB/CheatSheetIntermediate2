//
//  SubscriberExample.swift
//  CheatSheetIntermediate2
//
//  Created by Zachary on 30/10/22.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            // debounce for how long to wait after user stop typing to run the code below
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { textInTextField -> Bool in
                if textInTextField.count > 3 {
                    return true
                } else { return false }
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.count += 1
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else {return}
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberExample: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack{
            Text("\(vm.count)")
                .font(.largeTitle)
            
//            Text("Text is valid: \(vm.textIsValid.description)")
            
            TextField("type something...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay (alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                    .font(.title)
                    .padding(.trailing)
                }
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)

            
        }
        .padding()
    }
}

struct SubscriberExample_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberExample()
    }
}
