//
//  ContentView.swift
//  WordScramble
//
//  Created by Omar Khattab on 04/08/2022.
//

import SwiftUI

struct ContentView: View {

  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
    
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var showingError = false

  var body: some View {
    NavigationView {
        ZStack{
            RadialGradient(
                stops: [
                    .init(color:.yellow,location: 0.3),
                    .init(color: .purple, location: 0.3)],
                center: .top,
                startRadius: 200,
                endRadius: 700)
                .ignoresSafeArea()
        VStack{
            Text("Score For \(rootWord) : \(usedWords.count)")
                .frame(maxWidth: .infinity,alignment: .topLeading)
//                .frame(maxWidth: .infinity)
                .frame(alignment: .topTrailing)
                .padding()
            
            List{
                Section {
                  TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        
                }
          
                Section {
                  ForEach(usedWords, id: \.self) { word in
                    
                      HStack{
                          Image(systemName: "\(word.count).circle.fill")
                          Text(word)
                          
                      }
                  }
                }
                
            }
        }
    }
      .navigationTitle(rootWord)
      .onSubmit(addNewWord)
      .onAppear(perform: startGame)
      .alert(errorTitle, isPresented: $showingError) {
          Button("OK", role: .cancel) { }
      } message: {
          Text(errorMessage)
      }
      .toolbar {
          Button("Change Word", action: startGame)
      }.accentColor(.black)
            .font(.title2)
        

    }
  }

  func addNewWord() {
    // lowercase and trim the word, to make sure we don't add duplicate words with case differences
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

    // exit if the remaining string is empty
    guard answer.count > 2 else {
        wordError(title: "invalid word", message: "Word is three letters or less which is not allowed")
        return
    }
      
      
      guard answer != rootWord else{
          wordError(title: "invalid word", message: "Word you entered is same as root word")
          return
      }
            
      guard isOriginal(word: answer) else {
          wordError(title: "Word used already", message: "Be more original")
          return
      }

      guard isPossible(word: answer) else {
          wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
          return
      }

      guard isReal(word: answer) else {
          wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
          return
      }

      withAnimation{
    usedWords.insert(answer, at: 0)
    newWord = ""
      }
  }
    
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                usedWords = [String]()

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
