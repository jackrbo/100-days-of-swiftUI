//
//  DetailView.swift
//  Day60Challenge
//
//  Created by Richard-Bollans, Jack on 30/01/2022.
//

import SwiftUI

struct DetailView: View {
    let user : User
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Personal info")) {
                    List {
                        Text("Name: \(user.name)")
                        Text("Age: \(user.age)")
                        Text("Company: \(user.company)")
                        Text("Email: \(user.email)")
                        
                    }
                }
                Section(header: Text("About")){
                    Text(user.about)
                }
                Section(header: Text("Friends")) {
                    List {
                        ForEach(user.friends, id: \.id){ friend in
                            Text(friend.name)
                        }
                    }
                }
                Section(header: Text("Tags")){
                    GeometryReader { (geometry) in
                        FlexibleView(availableWidth: geometry.size.width, data: user.tags, spacing: CGFloat(10), alignment: .leading) { item in
                            Text(verbatim: item)
                              .padding(8)
                              .background(
                                RoundedRectangle(cornerRadius: 8)
                                  .fill(Color.gray.opacity(0.2))
                               )
                          }
                    }
                }
            }
            
            
        }
        .navigationTitle(user.name)
        
    }
}
struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
  let availableWidth: CGFloat
  let data: Data
  let spacing: CGFloat
  let alignment: HorizontalAlignment
  let content: (Data.Element) -> Content
  @State var elementsSize: [Data.Element: CGSize] = [:]

  var body : some View {
    VStack(alignment: alignment, spacing: spacing) {
      ForEach(computeRows(), id: \.self) { rowElements in
        HStack(spacing: spacing) {
          ForEach(rowElements, id: \.self) { element in
            content(element)
              .fixedSize()
              .readSize { size in
                elementsSize[element] = size
              }
          }
        }
      }
    }
  }

  func computeRows() -> [[Data.Element]] {
    var rows: [[Data.Element]] = [[]]
    var currentRow = 0
    var remainingWidth = availableWidth

    for element in data {
      let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

      if remainingWidth - (elementSize.width + spacing) >= 0 {
        rows[currentRow].append(element)
      } else {
        currentRow = currentRow + 1
        rows.append([element])
        remainingWidth = availableWidth
      }

      remainingWidth = remainingWidth - (elementSize.width + spacing)
    }

    return rows
  }
}

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let user = User(id: "dcda", isActive: true, name: "name", age: 4, company: "cc", email: "cds", address: "vdsg", about: "about", registered: Date.now, tags: [], friends: [])
        DetailView(user: user)
    }
}
