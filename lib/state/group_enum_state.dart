// 모달 상태 enum 뷰
enum GroupModalState {
  start, // 그룹 - 시작하기 뷰
  create, // 그룹 - 생성하기 뷰
  participation, // 그룹 - 참여하기 뷰
}

// 초기화면, 생성하기/참여하기로 인한 뷰
enum GroupViewlState {
  start, // 그룹 - 초기 뷰
  create, // 그룹 - 처음 냉장고 그룹을 생성할 시
  participation, // 그룹 - 냉장고 그룹이 1개 이상X, 그룹 참여할 시 보이는 뷰
}

