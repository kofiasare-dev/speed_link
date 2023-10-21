# frozen_string_literal: true

class CreateAccountsUsersAndProfiles < ActiveRecord::Migration[7.1]
  # rubocop:disable all
  def change
    enable_extension 'citext'

    create_table :accounts do |t|
      t.string :phone, null: false
      t.citext :email, null: false
      t.string :password_digest, null: false
      t.string :aasm_state, null: false, default: :active
      t.datetime :verified_at
      t.jsonb  :metadata, null: false, default: {}
      t.timestamps
    end

    add_index :accounts, :phone, unique: true, where: "aasm_state IN ('active', 'inactive')"
    add_index :accounts, :email

    create_table :users do |t|
      t.string :type, null: false
      t.belongs_to :account, foreign_key: true
      t.string :aasm_state
      t.jsonb  :metadata, null: false, default: {}
      t.timestamps
    end

    add_index :users, %i[account_id type], unique: true

    create_table :profiles do |t|
      t.string :firstname, null: false
      t.string :othernames, null: false
      t.text   :avatar_data
      t.belongs_to :account, foreign_key: true
      t.jsonb  :metadata, null: false, default: {}
      t.timestamps
    end
  end
end
