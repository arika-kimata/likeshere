# テーブル設計

## users テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| email      | string | null: false |
| password   | string | null: false |
| nickname   | string | null: false |
| profile    | string | null: false |

### Association
 - has_many :hobby
 - has_many :comments

## comments テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| text       | string     | null: false                    |
| user       | references | null: false, foreign_key: true |
| hobby      | references | null: false, foreign_key: true |

### Association
 - belong_to :users
 - belong_to :hobby

## hobby テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| title        | string     | null: false                    |
| release_date | data       | null: false                    |
| recommended  | string     | null: false                    |
| synopsis     | string     | null: false                    |
| image        | string     | null: false                    |
| category     | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association
 - belongs_to :users
 - belongs_to :category
 - has_many :comments

## categoryテーブル

| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| movie     | string | null: false |
| drama     | string | null: false |
| anime | string | null: false |
| game      | string | null: false |

### Association
 - has_many :hobbies