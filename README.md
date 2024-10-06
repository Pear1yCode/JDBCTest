# Information
LethalCompany라는 게임의 괴물들을 데이터베이스에 쌓아둔 데이터베이스로 괴물들을 검색하고 업데이트하고 제거해줄 수 있는 기능을 가진 데이터베이스입니다.

간단하게 설명하자면 다른 행성에 가서 행성에 있는 고철 등을 모아 돈을 버는 상황에 있는 외계생명체들의 정보를 저장하고 조회하며 새로운 괴물을 확인했을 때 추가하고 업데이트하고

잘못된 정보가 있을 때 제거할 수 있는 프로그램입니다.

<hr>

# 상황 : LETHAL COMPANY CREATURE DB (게임을 바탕으로 한 외계생명체 데이터 베이스 구현)

게임 LETHAL COMPANY의 상황과 똑같게 게임 내부에 들어와 있다고 생각하고 현재 우주에서 괴물들을 피해 스크랩을 모아야 하는 상황이다.

__해당 데이터베이스는 새롭게 온 인턴들의 교육자료이자 현재 일을 하던 오래된 직원들까지 실시간으로 사용하는 데이터베이스로 일을 하는데 가장 관련된 괴물의 정보와 행성들의 종류를 포함__ 하고 있다.

각 직원들은 4명의 조로 짜여져 있으며 4명의 조에서 가장 오래 살아남은 오래된 직원이 베테랑으로서 조장을 맡으며 각 팀의 회의로 새롭게 발견한 괴물은 데이터베이스에 추가할 수 있다.

모든 인원들은 생존을 위해 데이터베이스를 쌓아두고 새로운 인원들은 중요하게 숙지해야하는 데이터베이스이다.

따라서, __베테랑 직원들에게는 새로운 괴물의 정보와 새로운 달을 저장하는 데이터베이스__ 이며 __신규 직원에게는 살아남기 위한 교육자료형 데이터베이스로 설계__ 됐다고 할 수 있다.

업데이트가 있는 이유는 실수로 입력된 정보나 추후에 변경될 수 있는 내용을 넣고자하며 그때그때 수정이 가능하도록 조치해두었기에 데이터 변경이 가능하므로 위험함을 동반하는 값이 아닌 모든 값들은 꼭 데이터 삽입 시 기입해야 한다.

<hr>

# 모델링

## 논리
![image](https://github.com/user-attachments/assets/e3f6210c-d5b2-4b6c-8ec4-0b910df380ff)

## 물리
![image](https://github.com/user-attachments/assets/385e8016-eb49-4fdc-9bac-d75aafa9bdb8)

# 각 컬럼 설명

## ■ CREATURE (생명체)

### 식별코드 (PK)
      생명체 별 식별번호 부여 (생명체 이름 알파벳 첫 두글자 + 01)
### 이름
      생명체의 풀네임
### 생명체 여부
      생명체인지 여부 (생명체 Y, 기계 N)
### 살상가능 여부
      생명체를 죽일 수 있는 수준인지 여부 (Y, N)
### 공격력
    NULL 가능 => 알 수 없는 수준의 공격력을 지녔을 때)
### 개폐지능
    Y 스스로 문을 열 수 있음, 스스로 N 문을 열 수 없음
### 행성 코드 (FK)
    MOON에서의 PK키 (이름 변경 X)
### 생명체 위험도 구분번호 (FK)
    RISK에서의 PK키 (이름 변경 O)
### 크기 분류 아이디 (FK)
    SIZE에서의 PK키 ( 이름 변경 O )
<hr>
    
## ● MOON (행성)

### 행성 코드 (PK)
      행성별로 코드 부여 (행성 이름 알파벳 첫 글자 + 001)
### 행성명
      행성별 코드에 따른 행성 이름이 들어올 공간
### 행성 위험도 구분 아이디
    RISK에서의 PK 키 (이름 변경 O)
### 내부 유형 구분번호 (FK)\
    INTERIOR에서의 PK키 (이름 변경 X)
<hr>

## ○ INTERIOR (내부 유형)

### 내부 유형 구분 아이디 (PK)
      내부 유형 총 3가지 : 공장 : F01, 저택 : H01, 광산 : M01
### 유형
      위의 유형별 이름이 들어올 공간
### 생성 위치 구분번호 (FK)
    SPAWN에서의 PK키 (이름 변경 X)
<hr>

## ★ SPAWN (생성)

### 생성 위치 아이디 (PK)
      생성 위치 유형 총 3가지 : 내부 : I, 외부 : O, 내외부 : IO
### 생성 위치
      생성 위치별 이름이 들어올 공간
### 생성 수
      최대 생성 가능 수
<hr>

## ♨ RISK (위험성)

### 위험도 구분 아이디 (PK)
      행성과 생명체에서 FK로 사용될 PK
        위험도는 알파벳으로 표현 (S = 위험도 매우 높음, A = 위험도 높음, B = 위험도 중간, C = 위험도 낮음, F = 안전)
### 위험 단계
      위험도에 맞게 단계별 표현 (매우 높음, 높음, 중간, 낮음, 안전)
<hr>
## ◎ SIZE (크기)

### 분류 아이디 (PK)
      T = TINY, S = SMALL, M = MEDIUM, B = BIG, G = GIGANTIC
### 크기
    T = 매우 작음, S = 작음, M = 중간, B = 큼, G = 매우큼
<hr>

### 비고 
__TAG 이름 지정 구분__<br>
CODE<br>
종류가 많을 때로 지정<br>
ID<br>
단순한 구분 수준 (종류가 적음)
