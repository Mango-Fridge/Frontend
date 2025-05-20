// 모달 상태 enum 뷰
enum GroupModalState {
  // start, // 그룹 - 시작하기 뷰
  create, // 그룹 - 생성하기 뷰
  participation, // 그룹 - 참여하기 뷰
}

// 그룹에서 보이는 뷰 관리
enum GroupViewState {
  empty, // 그룹 - 그룹이 없을 경우 보이는 뷰
  exist, // 그룹 - 그룹이 있을 경우 보이는 뷰
  firstRequest, // 그룹 - 처음 그룹 참여 요청할 시 보이는 뷰
}

