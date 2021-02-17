# テーブル設計

## users テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| nickname     | string | null: false |
| email        | string | null: false |
| password     | string | null: false |
| lastname-ja  | string | null: false |
| firstname-ja | string | null: false |
| lastname-ka  | string | null: false |
| firstname-ka | string | null: false |
| birth-date   | string | null: false |

### Association

- has_many :items

## items テーブル

| Column     | Type          | Options     |
| ---------- | ------------- | ----------- |
| item-name  | string        | null: false |
| text       | text          | null: false |
| category   | string        | null: false |
| status     | string        | null: false |
| burden     | string        | null: false |
| area       | string        | null: false |
| days       | string        | null: false |
| price      | string        | null: false |



### Association

- belongs_to :users

## shipping-address テーブル

| Column        | Type    | Options     |
| ---------     | ------- | ------------|
| postal-code   | string  | null: false |
| prefectures   | string  | null: false |
| municipalites | string  | null: false |
| address       | string  | null: false |
| building-name | string  | null: false |
| phone-number  | string  | null: false |
