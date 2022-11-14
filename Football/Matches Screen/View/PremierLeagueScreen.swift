//
//  PremierLeagueScreen.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/9/22.
//

import SwiftUI
import Combine

struct PremierLeagueScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var vm: MatchesViewModel
    @State private var isFirstLoading = true
    @State private var favoriteColor = 0
    @State var isShowingFavorites = false
    
    var body: some View {
        
        ScrollViewReader { proxy in
            VStack{
                HandleSegmentedView()
               
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
                    isShowingFavorites = false
                } .frame(width: 50,height: 20)
                    .background(isShowingFavorites ? .white :  .black)
                    .cornerRadius(5)
                    .foregroundColor(isShowingFavorites ? .black :  .white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1))
                    .padding(5)
                
                
                Button(Strings.toggleFav){
                    loadMatchesUponFilter(showingFavs: true)
                    isShowingFavorites = true
                }
                .frame(width: 50,height: 20)
                .background(isShowingFavorites ? .black :  .white)
                .cornerRadius(5)
                .foregroundColor(isShowingFavorites ? .white :  .black)
                .overlay(
                 RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1))
                .padding(5)
                
                Spacer().frame(height: 30)
            }
        }   .font(.system(size: 18))
            .fontWeight(.bold)
            .foregroundColor(.black)
        
    }
    
    private func loadMatchesUponFilter(showingFavs: Bool){
        self.isFirstLoading.toggle()
        vm.showingFavs = showingFavs
        vm.sortFavs()
    }

    private func HandleSegmentedView() -> some View{
        Group{
            if vm.isDataLoaded{
                SegmentedView()
            }else{
                EmptyView()
            }
        }
    }
    
}

extension PremierLeagueScreen {
    static func build() -> PremierLeagueScreen {
        let vm = MatchesViewModel.build()
        return PremierLeagueScreen(vm: vm)
    }
}
