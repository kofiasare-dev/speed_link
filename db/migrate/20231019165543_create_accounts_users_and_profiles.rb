# frozen_string_literal: true

class CreateAccountsUsersAndProfiles < ActiveRecord::Migration[7.1]
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :accounts do |t|
      t.string :holder, null: false, default: 'Rider'
      t.string :phone, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :aasm_state, null: false, default: :active
      t.datetime :verified_at
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end

    add_index :accounts, %i[phone holder], unique: true, where: "aasm_state IN ('active', 'inactive')"
    add_index :accounts, :email
    add_index :accounts, :phone
    add_index :accounts, :holder
    add_index :accounts, :aasm_state

    create_table :users do |t|
      t.string :type, null: false
      t.belongs_to :account, foreign_key: true
      t.string :aasm_state
      t.jsonb  :metadata, null: false, default: {}
      t.timestamps
    end

    add_index :users, %i[account_id type], unique: true

    create_table :profiles do |t|
      t.string :firstname
      t.string :othernames
      t.text   :avatar_data
      t.belongs_to :account, foreign_key: true
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end
  end
end
