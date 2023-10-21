# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  avatar_data :text
#  firstname   :string           not null
#  metadata    :jsonb            not null
#  othernames  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint
#
# Indexes
#
#  index_profiles_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Profile < ApplicationRecord
  belongs_to :account

  validates :firstname, presence: true
  validates :othernames, presence: true
end
