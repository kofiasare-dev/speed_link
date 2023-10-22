# frozen_string_literal: true

require 'connection_pool'

class Cache
  class << self
    def redis
      @redis ||= ConnectionPool::Wrapper.new(size: 10, timeout: 3) do
        Redis.new(url: ENV['REDIS_HOST'])
      end
    end

    delegate :set, to: :redis
    delegate :get, to: :redis
    delegate :del, to: :redis

    def fetch(key, ex = nil)
      value = get key
      return value unless value.nil?

      raise ArgumentError, 'Block not provided' unless block_given?

      value = yield
      set(key, value, ex:)
      value
    end
  end
end
