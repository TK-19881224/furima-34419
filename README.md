# テーブル設計

## users テーブル

| Column              | Type   | Options     |
| ------------        | ------ | ----------- |
| nickname            | string | null: false |
| email               | string | null: false |
| encrypted_password  | string | null: false |
| lastname_ja         | string | null: false |
| firstname_ja        | string | null: false |
| lastname_ka         | string | null: false |
| firstname_ka        | string | null: false |
| birth_date          | date   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column       | Type     | Options                        |
| ------------ | ---------| ----------------------------   |
| name         | string   | null: false                    |
| text         | text     | null: false                    |
| category_id  | integer  | null: false, foreign_key: true |
| status_id    | integer  | null: false, foreign_key: true |
| burden_id    | integer  | null: false, foreign_key: true |
| area_id      | integer  | null: false, foreign_key: true |
| days_id      | integer  | null: false, foreign_key: true |
| price        | integer  | null: false                    |



### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user    | references | foreign_key: true |
| item    | references | foreign_key: true |

- has_one :shipping_address
- belongs_to :item

## shipping_addresses テーブル

| Column          | Type    | Options                        |
| --------------- | ------- | ------------------------------ |
| postal_code     | string  | null: false                    |
| area_id         | integer | null: false, foreign_key: true |
| municipalites   | string  | null: false                    |
| address         | string  | null: false                    |
| building_name   | string  |                                |
| phone_number    | string  | null: false                    |

- belongs_to :order
