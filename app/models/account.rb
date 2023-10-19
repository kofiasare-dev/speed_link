# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id            :bigint           not null, primary key
#  email         :citext           not null
#  password_hash :string
#  phone         :string           not null
#  status        :integer          default("unverified"), not null
#
# Indexes
#
#  index_accounts_on_email  (email)
#  index_accounts_on_phone  (phone) UNIQUE WHERE (status = ANY (ARRAY[1, 2]))
#
class Account < ApplicationRecord
  include Rodauth::Rails.model

  enum :status, unverified: 1, verified: 2, closed: 3

  has_one :user, dependent: :destroy
  has_one :profile, dependent: :destroy
end
