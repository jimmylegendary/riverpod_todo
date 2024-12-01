# Libaries
- 상태관리 : riverpod
- router : go_router
- local db : sqlite3
- remote db : firebase
  - login,db 관리
- mobile도 반영

# 기능
- bottom nav var
  - Todo
  - History
  - Setting
- todo에는 summary / start date / due date / 완료 or Fail 들어감
- atomic pattern

# TODO
- model data 정의
  - summary
  - start date
  - due date
  - status
- router page 등록
- page별 layout 설계

# Pages
## Todo
- floatingbutton으로 todo 입력하는 page 하나 만들어서
  - summary
  - start date(default = today)
  - due date(default = 1week)
  입력
- todo item이 list형태로 보여짐
- dismissible로
  - 삭제
  - 완료
- appbar에 calendar 넣어서 다른 날짜의 todo list 선택
- due date안에 완료가 안되면 자동으로 삭제됨

## History
- 날짜별로 완료여부를 색깔로 표시한 todo item을 볼 수 있음

## Settings
- user name
- (Optional)logout
- profile picture
- 한줄 소개글

## (Optional)Login page
- email signup/signin

