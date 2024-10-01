# LETHAL COMPANY CREATURE DB (게임을 바탕으로 한 외계생명체 데이터 베이스 구현)

게임 LETHAL COMPANY의 괴물들을 바탕으로 각 괴물의 데이터를 바탕으로 정보를 불러오거나 업데이트로 추가된 괴물을 데이터베이스에 추가하거나 제거할 수 있으며 어떤 정보를 가졌는지 확인할 수 있음

행성 별로 괴물의 분포를 확인할 수 있고 위험한 괴물을 모아서 확인하는 등 다양하게 사용할 수 있다.

<hr>

# 모델링

## 논리
![image](https://github.com/user-attachments/assets/9ccc8a79-e328-4013-b20c-127a24e306a6)

## 물리
![image](https://github.com/user-attachments/assets/a7b72365-c50a-4a53-9a00-132b635904ab)

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
