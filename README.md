# README

# アプリケーション名
## TALK ROOM

## アプリケーション概要
- 相手を検索して、トークルームを作成しチャット感覚で、会話のやりとりができます。
- 文章以外にも画像の送信も行えます。
- 既読機能も実装されてます。
- ユーザーサインアップを行わないと、自動的にログイン画面に遷移させられます。


## URL
[TALK ROOM](https://talk-room-28346.herokuapp.com/)


## テスト用アカウント
- BASIC認証 ID:admin
- BASIC認証 PASSWORD:2234
- テスト用アカウント メールアドレス:aaa@aaa(bbb@bbbでもログイン可能)
- テスト用アカウント PASSWORD:0000pppp


## 利用方法
- テスト用アカウントでログインします。
- トーク相手を探し、トークルームを作成します。
- トークルーム作成後、投稿フォームから画像や会話の送信ができます。
- トーク内の削除ボタンを押す事で、一度送信したトークを削除できます。
- 相手から送られてきたメッセージについてはクリックをする事で既読にできます。（本アプリでは、トークの背景色が変わるだけです）


## 目指した課題解決
今回のアプリでは、ビジネス上での連絡手段を、メールよりも簡潔に行えるようにする為に実装しました。
また、既存のSNS等を通じての連絡は、プライベート上やビジネスマナー上、相応しくないように思った為、実装しました。


## 要件定義

| 機能                            | 目的                                    | 詳細                             |
| ------------------------------ | --------------------------------------- | ------------------------------- |
| ユーザーサインイン、サインアップ機能 | ユーザー毎に管理できるようにするため。          | deviseを導入し、実装を行う。        |
| トークの送信                     | トーク内容をお互いに確認できるようにするため。  | トークルーム内でトークを送信できる。  |
| 画像の送信                      | 画像を用いて、トーク内容の充実を図る。          | ActiveStorageを使用し、実装する。  |
| 既読機能の実装                   | 相手が確認したかどうか、判断できるようにするため。| Ajaxを用いた非同期通信にて実装する。 |
| トークルームの作成                | トーク内容を保存しておけるようにするため。      | トークルーム名を設定できるようにする。|

## 実装予定の機能

- トーク相手の承認機能。現状では、データベースに登録された全てのユーザー同士がトークをしあえる状態なので、  相手にトークの申請を行い相手がに承認されればトークルームが作成できるようにします。
- トークのテンプレートを用意し、簡単な形式の問答ならば1クリックでトークを遅れるように実装します。


## usersテーブル

| Column           | Type     | options        |
| ---------        | -------- | -------------- |
| family_name      | string   | null: false    |
| last_name        | string   | null: false    |
| family_name_kana | string   | null: false    |
| last_name_kana   | string   | null: false    |
| email            | string   | null: false    |
| password         | string   | null: false    |

### Association
- has_many :room_users
- has_many :rooms, through: room_users
- has_many :messages
- has_many :relations
- has_many :followers, through: :relations
- has_many :followings, through: :relations



## roomsテーブル

| Column           | Type        | options         |
| ---------------- | ----------- | --------------- |
| name             | string      | null: false     |

### Association
- has_many :room_users
- has_many :users, through: room_users, dependent: :destroy
- has_many :messages, dependent: :destroy



## room_usersテーブル

| Column         | type         | options                         |
| -------------- | ------------ | ------------------------------- |
| user           | references   | null: false, foreign_key: true  |
| room           | references   | null: false, foreign_key: true  |

### Association
- belongs_to :user
- belongs_to :room



## messagesテーブル

| Column         | type        | options                         |
| -------------- | ----------- | ------------------------------- |
| content        | string      |                                 |
| user           | references  | null: false, foreign_key: true  |
| room           | references  | null: false, foreign_key: true  |

### Association
- belongs_to :user
- belongs_to :room
- has_one_attached :image



## relationテーブル

| Column      | type          | options                        |
| -------     | ------------- | ------------------------------ |
| follower    | references    | null: false, foreign_key: true |
| following   | references    | null: false, foreign_key: true |

### Association
- belongs_to :follower, class_name: user
- belongs_to :following, class_name: user