//
//  ContentView.swift
//  showSlideOverCard_Ex
//
//  Created by 양시관 on 4/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSlideOverCard = false

    var body: some View {
        ZStack {
            // 기본 홈뷰 콘텐츠
            VStack {
                Button("추가") {
                    showSlideOverCard.toggle()
                }
                .frame(width: 100, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // 슬라이드 오버 카드
            if showSlideOverCard {
                SelectDayView(showSlideOverCard: $showSlideOverCard)
                    .animation(.spring())
            }
        }
    }
}


struct SelectDayView: View {
    @Binding var showSlideOverCard: Bool

    var body: some View {
        ZStack {
            // 슬라이드 카드 배경
            Color.white
                .cornerRadius(0) // 모든 모서리를 둥글게 처리
                .shadow(radius: 5) // 카드에 그림자 추가
                .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.90) // 카드의 크기 조정
                .offset(x: showSlideOverCard ? UIScreen.main.bounds.width * 0.05 : UIScreen.main.bounds.width, y: 0)
                .transition(.move(edge: .trailing)) // 오른쪽에서 들어오는 애니메이션

            // 카드 내용
            VStack {
                // 상단의 '뒤로 가기' 버튼
                HStack {
                    Button(action: {
                        showSlideOverCard = false
                    }) {
                        Image(systemName: "chevron.left") // 뒤로 가기 아이콘
                            .foregroundColor(.gray)
                            .padding()
                    }
                    Spacer()
                }

                // SelectDayView의 나머지 콘텐츠
                Text("SelectDayView 내용")
                    .padding()
            }
            .frame(width: UIScreen.main.bounds.width * 0.95) // 카드 내용의 너비를 카드와 동일하게 조정
            .padding(.leading, 20) // 카드 내용에 왼쪽 패딩 추가
        }
        .edgesIgnoringSafeArea(.vertical) // 상단과 하단 Safe Area 무시
    }
}

// SwiftUI에서 특정 모서리만 둥글게 처리하는 확장 기능
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
