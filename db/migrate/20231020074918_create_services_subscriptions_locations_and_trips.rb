# frozen_string_literal: true

class CreateServicesSubscriptionsLocationsAndTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, null: false, default: false
      t.integer :person_capacity, null: false, default: 1
      t.text :logo_data
      t.jsonb :metadata, null: false, default: {}

      t.timestamps
    end

    create_table :service_configs do |t|
      t.belongs_to :service, foreign_key: true
      t.boolean :active, null: false, default: false
      t.integer :basic_fare_cents, null: false, default: 0
      t.integer :price_per_km_cents, null: false, default: 0
      t.integer :price_per_min_cents, null: false, default: 0
      t.integer :commission_cents, null: false, default: 1000

      t.timestamps
    end

    create_table :subscriptions do |t|
      t.references :driver, null: false, foreign_key: { to_table: 'users' }
      t.belongs_to :service, null: false, foreign_key: true

      t.timestamps
    end

    create_table :locations do |t|
      t.belongs_to :locateable, polymorphic: true
      t.st_point :latlon, geographic: true
      t.jsonb :metadata, null: false, default: {}
      t.integer :position
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    create_table :cabs do |t|
      t.references :driver, null: false, foreign_key: { to_table: 'users' }
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.string :license_plate, null: false
      t.integer :seats, null: false, default: 4
      t.string :color, null: false
      t.boolean :approved, default: false
      t.boolean :active, default: false

      t.timestamps
    end

    create_table :trip do |t|
      t.string :name
      t.references :rider, null: false, foreign_key: { to_table: 'users' }
      t.references :driver, null: false, foreign_key: { to_table: 'users' }
      t.belongs_to :cab, null: false, foreign_key: true
      t.belongs_to :service, null: false, foreign_key: true
      t.string :aasm_state, null: false, default: 'pending'
      t.jsonb :metadata, null: false, default: {}
      t.datetime :started_at, null: false
      t.datetime :cancelled_at
      t.datetime :ended_at, null: false

      t.timestamps
    end

    add_index :services, :name, unique: true
    add_index :subscriptions, %i[driver_id service_id], unique: true
    add_index :cabs, %i[driver_id license_plate], unique: true
  end
end
