# README

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
- has_many :followers, through: relationship
- has_many :followings, through: relationship



## roomsテーブル

| Column           | Type        | options         |
| ---------------- | ----------- | --------------- |
| name             | string      | null: false     |

### Association
- has_many :room_users
- has_many :users, through: room_users
- has_many :messages



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



## relationshipテーブル

| Column      | type          | options                        |
| -------     | ------------- | ------------------------------ |
| follower    | references    | null: false, foreign_key: true |
| following   | references    | null: false, foreign_key: true |

### Association
- belongs_to :follower, class_name: user
- belongs_to :following, class_name: user