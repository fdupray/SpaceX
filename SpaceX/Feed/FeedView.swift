//
//  ContentView.swift
//  SpaceX
//
//  Created by Frederick Dupray on 27/09/2021.
//

import SwiftUI
import SafariServices

struct FeedView: View {
    
    @ObservedObject var viewModel: FeedViewModel
    
    @State var isFilterPopoverPresented: Bool = false
    
    var body: some View {
        
        if viewModel.launches.isEmpty {
            
            NoLaunchesView()
        }
        
        else {
            
            LaunchesTable(companyInfo: $viewModel.companyInfo, launches: $viewModel.launches)
                .toolbar {
                    Button {
                        
                        viewModel.router.popover(show: true)
                        
                    } label: {
                         
                        Text("Filter")
                            .foregroundColor(.blue)
                    }
                    .fullScreenCover(isPresented: $viewModel.isPopoverPresented) {
                        
                        if viewModel.isPopoverPresented {
                            
                            viewModel.router.popover(show: false)
                        }
                        
                    } content: {
                        
                        viewModel.router.popoverView()
                    }
                }
        }
    }
}

/* -- PLEASE READ !!!!
 
These views could be (and in many cases, should be) separated in different files. However, for this case I'm regrouping them in one file!
 
*/

struct LaunchesTable: View {
    
    @Binding var companyInfo: CompanyInfo?
    @Binding var launches: [Launch]
    
    @State var links: Links? = .none
    @State var urlString: String = ""
    @State var isPresentingActions: Bool = false
    @State var isPresentingSafari: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            Section (header: SectionHeader(title: "Company")) {
                
                Text(companyInfo?.description ?? "Welcome to SpaceX 🚀")
                    .spaceXFont(.body)
                    .padding()
            }
            
            Section (header: SectionHeader(title: "Launches")) {
                
                ForEach (0..<launches.count) { i in
                    
                    let launch = launches[i]
                    
                    FeedCellView(viewModel: FeedCellViewModel(launch: launch))
                        .padding()
                        .onTapGesture {
                            
                            if launch.links != nil {

                                self.links = launch.links
                                self.isPresentingActions = true
                            }
                        }
                }
            }
        }
        .sheet(isPresented: $isPresentingSafari, onDismiss: nil, content: {
            SafariView(urlString: urlString)
        })
        .confirmationDialog("Links", isPresented: $isPresentingActions) {
            
            if let article = links?.article {
                Button("Article") {
                    presentSafariWithURL(article)
                }
            }
            
            if let wiki = links?.wikipedia {
                Button("Wikipedia") {
                    presentSafariWithURL(wiki)
                }
            }
            
            if let youtube = links?.youtube_id {
                Button("Youtube") {
                    presentSafariWithURL("http://youtu.be/\(youtube)")
                }
            }
        }
    }
    
    func presentSafariWithURL(_ urlString: String) {
        self.urlString = urlString
        isPresentingSafari = true
    }
}

struct NoLaunchesView: View {
    
    var body: some View {
        
        VStack {
            
            Image("error_icon")
                .padding()
            
            Text("We couldn't load content")
                .spaceXFont(.body)
                .padding()
        }
    }
}

struct SafariView: UIViewControllerRepresentable {

    let urlString: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let url = URL(string: urlString)!
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(viewModel: FeedViewModel(dataFetching: MockDataFetcher(), router: MockRouter()))
    }
}
