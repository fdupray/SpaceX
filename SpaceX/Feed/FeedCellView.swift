//
//  FeedCellView.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import SwiftUI

struct FeedCellViewModel {
    
    let launch: Launch
}

struct FeedCellView: View {
    
    var viewModel: FeedCellViewModel
    
    @State var isExpanded: Bool = false
        
    var body: some View {
        
        HStack (alignment: .top) {
            
            AsyncImage(url: URL(string: viewModel.launch.links?.patch?.small ?? "")) { phase in
                
                let size = CGSize(width: 50, height: 50)
                
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: size.width, height: size.height, alignment: .center)
                }
                else {
                    Text("🚀")
                        .frame(width: size.width, height: size.height, alignment: .center)
                }
            }
            .padding()
            
            VStack (alignment: .leading, spacing: 8) {
                
                CellRowView(description: "Mission", text: viewModel.launch.name)
                
                if isExpanded {
                    
                    Group {
                        
                        CellRowView(description: "Date/Time", text: viewModel.launch.formattedDateString)
                        
                        if let rocket = viewModel.launch.rocketObject {
                            CellRowView(description: "Rocket", text: "\(rocket.name) / \(rocket.type)")
                        }
                        
                        CellRowView(description: "Days", text: viewModel.launch.formattedDaysString)
                    }
                }
                
                Button(isExpanded ? "Collapse ↑" : "Expand ↓") {
                    isExpanded.toggle()
                }
                .font(.system(size: 12, weight: Font.Weight.medium, design: Font.Design.default))
            }
            
            Spacer()
        }
    }
}

private struct CellRowView: View {
    
    let description: String
    let text: String
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 4) {
            
            Text("\(description):")
                .spaceXFont(.body)
            
            Text(text)
                .spaceXFont(.subtitle)
        }
    }
}

struct FeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        FeedCellView(viewModel: FeedCellViewModel(launch: Launch(id: "", name: "Rocket 1", rocket: "Rock-et", date_local: "Some time", links: Links(patch: Patch(small: "")))))
    }
}
