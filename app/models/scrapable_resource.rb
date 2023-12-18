class ScrapableResource < ApplicationRecord
  validates :fields, :url, presence: true
end
