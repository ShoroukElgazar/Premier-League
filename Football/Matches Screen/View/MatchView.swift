//
//  MatchView.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/11/22.
//

import SwiftUI
import Kingfisher


struct MatchView: View {
    
    private let match: MatchResponse?
    private var winner : String
    private var isMatchFav : Bool
    let onItemSelected: (MatchResponse) -> Void
    
    public init(match: MatchResponse?,winner: String,isMatchFav: Bool, onItemSelected: @escaping (MatchResponse) -> Void) {
        self.match = match
        self.winner = winner
        self.isMatchFav = isMatchFav
        self.onItemSelected = onItemSelected
    }
    
    private var homeTeam : String{
        (match?.homeTeam?.shortName ?? "")
    }
    private var awayTeam : String{
        (match?.awayTeam?.shortName ?? "")
    }
    
    private var homeTeamLogo : URL?{
        URL(string:match?.homeTeam?.crest ?? "")
    }
    
    var awayTeamLogo : URL?{
        URL(string: match?.awayTeam?.crest ?? "")
    }
    
    private var premierLeagueLogo : URL?{
        URL(string: match?.competition?.emblem ?? "")
    }
    
    private var homeResult : String?{
        String(match?.score?.fullTime?.home ?? 0)
    }
    private var awayResult : String?{
        String(match?.score?.fullTime?.away ?? 0)
    }
    private var status: Status{
        (match?.status ?? .finished)
    }
  
    var body: some View {
        VStack(spacing: 0){
            FavView()
            GameResult()
            
        }
        .cardView()
        .cornerRadius(5)
        .shadow(radius: 3)
        
    }
    
    private func FavView() -> some View {
        HStack{
            Image(systemName: isMatchFav ? "star.fill" : "plus")
                .foregroundColor(isMatchFav ? .green : .black)
                .padding(.vertical,5)
                .padding(.leading,5)
                .font(.system(size: 15))
                .onTapGesture {
                    guard let match = match else{
                        return
                    }
                    onItemSelected(match)
                }
            
            Text(isMatchFav ? Strings.following : Strings.follow)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Spacer().frame(maxWidth: .infinity)
        }  .background(Color.gray.opacity(0.5))
        
    }
    
    private func FinishedView() -> some View {
        VStack(spacing: 0){
            HStack{
                HomeTeamView()
                Spacer().frame(maxWidth: .infinity)
                Text(homeResult ?? "")
            }
            .padding(.top,5)
            .padding(.leading,5)
            .padding(.trailing,10)
            .padding(.bottom,5)
            
            
            Divider().background(Color.gray)
                .frame(height: 2)
                .padding(.horizontal,5)
            
            HStack{
                AwayTeamView()
                Spacer().frame(maxWidth: .infinity)
                Text(awayResult ?? "")
            }
            .padding(.top,5)
            .padding(.leading,5)
            .padding(.trailing,10)
            .padding(.bottom,5)
        }
        .frame(maxWidth: .infinity)
        
        
    }
    
    
    private func GameResult() -> some View{
        Group{
            switch status{
            case .finished:
               FinishedView()
            case .postponed:
                ScheduledView()
            case .scheduled:
                ScheduledView()
            case .timed:
                ScheduledView()
            case .inPlay:
                ScheduledView()
            }
        }
    }
    
    private func Logo(imageURL: URL?) -> some View {
        
        KFImage.url(imageURL)
            .placeholder{KFImage.url(premierLeagueLogo).resizable()}
            .resizable()
            .loadImmediately()
            .background(.white)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
    
    private func HomeTeamView() -> some View {
        HStack{
            Logo(imageURL: homeTeamLogo)
            Text(homeTeam)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
    }
    
    private func AwayTeamView() -> some View {
        HStack{
            Logo(imageURL: awayTeamLogo)
            Text(awayTeam)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
    }
    
    private func ScheduledView() -> some View {
        VStack(alignment:.leading,spacing: 0){
            HStack(spacing: 0){
                VStack(alignment:.leading,spacing: 0){
                    HomeTeamView()
                        .padding(.top,5)
                        .padding(.leading,5)
                        .padding(.trailing,10)
                        .padding(.bottom,5)
                    AwayTeamView()
                        .padding(.top,5)
                        .padding(.leading,5)
                        .padding(.trailing,10)
                        .padding(.bottom,5)
                }.frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .leading)
                    .padding(.horizontal, 5.0)

                VStack(alignment:.center,spacing: 0){
                    Text(match?.matchTime ?? "")
                } .padding(.trailing,10)
            }
        }
    }
}
