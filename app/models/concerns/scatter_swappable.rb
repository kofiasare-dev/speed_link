# frozen_string_literal: true

module ScatterSwappable
  extend ActiveSupport::Concern

  def scatter_id
    return if id.nil?

    @scatter_id ||= ScatterSwap.hash(id).to_i
  end

  module ClassMethods
    def find_by_scatter_id(scatter_id)
      where(id: ScatterSwap.reverse_hash(scatter_id).to_i).first
    end

    def find_by_scatter_id!(scatter_id)
      record = find_by_scatter_id(scatter_id)
      raise ActiveRecord::RecordNotFound unless record

      record
    end

    def find_by_scatter_ids(*scatter_ids)
      where(id: scatter_ids.flatten.map { |scatter_id| ScatterSwap.reverse_hash(scatter_id).to_i })
    end
  end
end
