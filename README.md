# テーブル設計

## users テーブル

| Column              | Type   | Options     |
| ------------        | ------ | ----------- |
| nickname            | string | null: false |
| email               | string | unique: true|
| encrypted_password  | string | null: false |
| lastname_ja         | string | null: false |
| firstname_ja        | string | null: false |
| lastname_ka         | string | null: false |
| firstname_ka        | string | null: false |
| birth-date          | date   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column       | Type     | Options     |
| ------------ | ---------| ----------- |
| name         | string   | null: false |
| text         | text     | null: false |
| category_id  | integer  | null: false |
| status_id    | integer  | null: false |
| burden_id    | integer  | null: false |
| area_id      | integer  | null: false |
| days_id      | integer  | null: false |
| price        | integer  | null: false |



### Association

- belongs_to :user
- belongs_to :orders

## orders テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ------------|
| user_id         | references |             |
| item_id         | references |             |

- has_one :shipping-address


## shipping-address テーブル

| Column          | Type    | Options     |
| --------------- | ------- | ------------|
| postal_code     | string  | null: false |
| prefectures_id  | integer | null: false |
| municipalites   | string  | null: false |
| address         | string  | null: false |
| building_name   | string  | null: false |
| phone_number    | string  |             |

- belongs_to :orders
