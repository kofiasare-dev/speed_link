# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  aasm_state :string
#  metadata   :jsonb            not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint
#
# Indexes
#
#  index_users_on_account_id           (account_id)
#  index_users_on_account_id_and_type  (account_id,type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class User < ApplicationRecord
  belongs_to :account
end
