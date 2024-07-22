# 🍴 mealmatch

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## 💡 Project Introduction
교환학생을 위한 식당 및 메뉴 필터링 지도 애플리케이션
**Meal Match**는 교환 학생들이 각자의 식문화와 선호도에 맞는 식당과 메뉴를 쉽게 찾을 수 있도록 돕는 애플리케이션입니다. 한국의 식당 데이터를 기반으로 특정 식단 성향(비건, 락토 베지테리언, 할랄 등) 필터링을 적용하여 사용자에게 맞춤형 추천을 제공합니다.


## 🪄 Development Timeline
2024.04.10 ~ 24.06.22


## 🗝️ Development Environment
**IDE**: Android Studio

**Framework**: Flutter

**Programming Language**: Dart

**Backend/Database**: Firebase

**Data Collection**: Python Selenium for web scraping (Naver Map)

**Data Preprocessing and Manipulation**: Python pandas, numpy


## 🎯 Functions
1. **사용자 인증 및 로그인**
   - 회원가입 및 로그인시 ID/PW 유효성 검사
   - Firebase Authentication을 이용하여 구글 소셜 로그인 기능 제공
2. **식당 필터링**
   - 사용자의 식단 제한 조건(비건, 할랄 등)을 적용하여 필터링된 식당 목록 제공
   - 실시간 데이터베이스 업데이트로 최신 정보 제공
3. **지도 기반 식당 표시**
   - 네이버 지도 API 활용한 식당 위치 표시
   - 필터링된 결과를 지도에 마커로 표시하여 사용자의 위치 기반 탐색 지원
4. **식당 상세 정보**
   - 식당 메뉴, 운영 시간, 리뷰 등 상세 정보 제공
   - 사용자는 식당을 즐겨찾기에 추가하고 리뷰 작성 가능
5. **검색 기능**
   - 메뉴명, 식당명으로 검색 가능하여 빠른 탐색 지원
6. **북마크(즐겨찾기) 관리**
   - 사용자가 즐겨찾기한 식당 목록을 관리하고, 추가 및 삭제 가능


## 🧀 Implementation Challenges
1. 데이터 수집 및 전처리
   - 네이버 지도 웹페이지는 동적 웹페이지로, 구조가 복잡: 여러 개의 iframe이 겹쳐있는 구조
   - 식당마다 제공하는 정보의 범위가 달라서, 크롤링 중 발생하는 오류를 잡기 위해 예외 처리

2. 실시간 데이터 동기화
   - Firebase를 활용한 실시간 데이터 동기화 및 업데이트 과정에서 데이터의 일관성을 유지
   -  Firebase Realtime Database의 구조를 체계적으로 설계하고, 데이터 변경 시 실시간으로 반영되도록 구현
