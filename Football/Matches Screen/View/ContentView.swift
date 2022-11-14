//
//  ContentView.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/9/22.
//

import SwiftUI
import CoreData
import Combine

struct PremierLeagueScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var vm: MatchesViewModel
    @State private var isFirstLoading = true
    @State private var favoriteColor = 0
    
    var body: some View {
      
            ScrollViewReader { proxy in
                VStack{
                    SegmentedView()
                    
                    ListOfMatches(proxy: proxy)
                }
            
            }.errorAlert(error: $vm.error)
    }
    
    private func ListOfMatches(proxy: ScrollViewProxy) -> some View {
        
        List{
            ForEach(vm.orderedGroup.keys, id: \.self) { key in
                Section(header: Text(key!).frame(height: 20)) {
                    let values = vm.orderedGroup[key]
                    ForEach(values ?? []) { val in
                        MatchesView(proxy: proxy, matchRes: val)
                    }
                }.font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

            }.listRowSeparator(.hidden)
                .background(Color.clear)
          
        }   .padding(.top, 10)
            .listStyle(.plain)
            .background(Color.clear)
           
    }
        
    private func MatchesView(proxy: ScrollViewProxy,matchRes: MatchResponse) -> some View{
            Group{
                MatchView(match: matchRes, winner: matchRes.winner ?? "", isMatchFav: vm.contains(matchRes)){ match in
                    vm.toggleFav(item: match)
                }.id(matchRes.id)
                    .onAppear{
                        if isFirstLoading{
                            proxy.scrollTo(vm.id,anchor: .top )
                            isFirstLoading = false
                        }
            }
        }
    }
    
    private func SegmentedView() -> some View{
        VStack{
            HStack{
                Spacer().frame(height: 30)
                Button(Strings.all){
                    loadMatchesUponFilter(showingFavs: false)
                }.padding(.trailing)
                
                Button(Strings.toggleFav){
                    loadMatchesUponFilter(showingFavs: true)
                }
                Spacer().frame(height: 30)
            }
        }   .font(.system(size: 18))
            .fontWeight(.bold)
            .foregroundColor(.black)
//            .background(Color.black)
        
    }
    
    private func loadMatchesUponFilter(showingFavs: Bool){
        self.isFirstLoading.toggle()
        vm.showingFavs = showingFavs
        vm.sortFavs()
    }

    
}

extension PremierLeagueScreen {
    static func build() -> PremierLeagueScreen {
        let vm = MatchesViewModel.build()
        return PremierLeagueScreen(vm: vm)
    }
}
