
Enum "film_rating_enum" {
  "G"
  "PG"
  "PG-13"
  "R"
  "NC-17"
}

Table "address" {
  "address_id" SMALLINT [pk, not null, increment]
  "address" VARCHAR(50) [not null]
  "address2" VARCHAR(50) [default: NULL]
  "district" VARCHAR(20) [not null]
  "city" VARCHAR(50)  [not null]
  "country" VARCHAR(50) [not null]
  "postal_code" VARCHAR(10) [default: NULL]
  "phone" VARCHAR(20) [not null]
  "last_update" TIMESTAMP [not null, default: `CURRENT_TIMESTAMP`]


}


Table "customer" {
  "customer_id" SMALLINT [pk, not null, increment]
  "store_id" TINYINT [not null]
  "first_name" VARCHAR(45) [not null]
  "last_name" VARCHAR(45) [not null]
  "email" VARCHAR(50) [default: NULL]
  "address_id" SMALLINT [not null]
  "active" BOOLEAN [not null, default: TRUE]
  "create_date" DATETIME [not null]
  "last_update" TIMESTAMP [default: `CURRENT_TIMESTAMP`]

Indexes {
  store_id [name: "idx_fk_store_id"]
  address_id [name: "idx_fk_address_id"]
  last_name [name: "idx_last_name"]
}
}

Table "film" {
  "film_id" SMALLINT [pk, not null, increment]
  "title" VARCHAR(128) [not null]
  "category" VARCHAR(25) [not null]
  "description" TEXT [default: NULL]
  "release_year" YEAR [default: NULL]
  "language" TINYINT [not null]
  "original_language" CHAR(20) [default: NULL]
  "rental_duration" CHAR(20) [not null, default: 3]
  "rental_rate" DECIMAL(4,2) [not null, default: 4.99]
  "length" SMALLINT [default: NULL]
  "replacement_cost" DECIMAL(5,2) [not null, default: 19.99]
  "rating" film_rating_enum [default: "G"]
  "special_features" "SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes')" [default: NULL]
  "last_update" TIMESTAMP [not null, default: `CURRENT_TIMESTAMP`]

Indexes {
  title [name: "idx_title"]
}
}

Table "actor" {
  "first_name" VARCHAR(45) [not null]
  "last_name" VARCHAR(45) [not null]
  "film_id" SMALLINT [not null]
  "last_update" TIMESTAMP [not null, default: `CURRENT_TIMESTAMP`]

Indexes {
  (film_id) [pk]
  film_id [name: "idx_fk_film_id"]
}
}

Table "inventory" {
  "inventory_id" MEDIUMINT [pk, not null, increment]
  "film_id" SMALLINT [not null]
  "store_id" TINYINT [not null]
  "last_update" TIMESTAMP [not null, default: `CURRENT_TIMESTAMP`]

Indexes {
  film_id [name: "idx_fk_film_id"]
  (store_id, film_id) [name: "idx_store_id_film_id"]
}
}


Table "rental" {
  "rental_id" INT [pk, not null, increment]
  "payment_amount" DECIMAL(5,2) [not null]
  "rental_date" DATETIME [not null]
  "inventory_id" MEDIUMINT [not null]
  "customer_id" SMALLINT [not null]
  "return_date" DATETIME [default: NULL]
  "staff_id" TINYINT [not null]
  "last_update" TIMESTAMP [not null, default: `CURRENT_TIMESTAMP`]

Indexes {
  (rental_date, inventory_id, customer_id) [unique, name: "rental_index_13"]
  inventory_id [name: "idx_fk_inventory_id"]
  customer_id [name: "idx_fk_customer_id"]
  staff_id [name: "idx_fk_staff_id"]
}
}

Table "staff" {
  "staff_id" TINYINT [pk, not null, increment]
  "first_name" VARCHAR(45) [not null]
  "last_name" VARCHAR(45) [not null]
  "address_id" SMALLINT [not null]
  "picture" BLOB [default: NULL]
  "email" VARCHAR(50) [default: NULL]
  "store_id" TINYINT [not null]
  "active" BOOLEAN [not null, default: TRUE]
  "username" VARCHAR(16) [not null]
  "password" VARCHAR(40) [default: NULL]
  "last_update" TIMESTAMP [not null, default: `CURRENT_TIMESTAMP`]

Indexes {
  store_id [name: "idx_fk_store_id"]
  address_id [name: "idx_fk_address_id"]
}
}

Table "store" {
  "store_id" TINYINT [pk, not null, increment]
  "manager_staff_id" TINYINT [not null]
  "address_id" SMALLINT [not null]
  "last_update" TIMESTAMP [not null, default: `CURRENT_TIMESTAMP`]

Indexes {
  manager_staff_id [unique, name: "idx_unique_manager"]
  address_id [name: "idx_fk_address_id"]
}
}


Ref:"actor"."film_id" < "film"."film_id" [update: cascade, delete: restrict]

Ref:"address"."address_id" < "customer"."address_id" [update: cascade, delete: restrict]

Ref:"store"."store_id" < "customer"."store_id" [update: cascade, delete: restrict]

Ref:"store"."store_id" < "inventory"."store_id" [update: cascade, delete: restrict]

Ref:"film"."film_id" < "inventory"."film_id" [update: cascade, delete: restrict]

Ref:"staff"."staff_id" < "rental"."staff_id" [update: cascade, delete: restrict]

Ref:"inventory"."inventory_id" < "rental"."inventory_id" [update: cascade, delete: restrict]

Ref:"customer"."customer_id" < "rental"."customer_id" [update: cascade, delete: restrict]

Ref:"store"."store_id" < "staff"."store_id" [update: cascade, delete: restrict]

Ref:"address"."address_id" < "staff"."address_id" [update: cascade, delete: restrict]

Ref:"staff"."staff_id" < "store"."manager_staff_id" [update: cascade, delete: restrict]

Ref:"address"."address_id" < "store"."address_id" [update: cascade, delete: restrict]


