//
//  LangSelector.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/31/23.
//

//import SwiftUI
//
//struct LangSelector: View {
//    @State private var selected = "English"
//    let languageOptions = ["Arabic", "Chinese", "English", "German", "Indonesian", "Japanese", "Korean", "Russian", "Spanish"]
//
//    var body: some View {
//        
//        VStack {
//            Picker("Select a language", selection: $selected){
//                ForEach(languageOptions, id: \.self){
//                    Text($0)
//                }
//            }
//            .pickerStyle(.menu)
//            Text("Translate language to: \(selected)")
//        }
//    }
//}
//               
//               
////            }
////        }) {
////            HStack {
////                Text(selectedOption == nil ? placeholder : selectedOption!.language)
////                    .fontWeight(.medium)
////                    .foregroundColor(selectedOption == nil ? .gray: .black)
////
////                Spacer()
////
////                Image(systemName: self.isOptionsPresented ? "chevron.up" : "chevron.down")
////                    .fontWeight(.medium)
////                    .foregroundColor(.black)
////
////
////            }
////        }
////        .padding()
////        .overlay {
////            RoundedRectangle(cornerRadius: 5)
////                .stroke(.gray, lineWidth: 2)
////        }
////
////        .overlay(alignment: .top) {
////
////            VStack {
////                if self.isOptionsPresented {
////                    Spacer(minLength: 51)
////                    LanguageList(options: self.langauges) { option in
////                        self.isOptionsPresented = false
////                        self.selectedOption = option
////
////
////
////                    }
////                }
////            }
////        }
////        .padding(.horizontal)
////
////    }
////}
////
//
//
//
//struct LangSelector_Previews: PreviewProvider {
//    static var previews: some View {
//        LangSelector()
//    }
//}
