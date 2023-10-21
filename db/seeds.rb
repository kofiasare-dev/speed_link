# frozen_string_literal: true

ActiveRecord::Base.transaction do
  Dir[Rails.root.join('db/seed_dir/*.rb')].each do |seed_file|
    Rails.logger.info ">>> Seeding #{seed_file}..."
    require seed_file
  end
end
