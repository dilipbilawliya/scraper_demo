require 'rails_helper'

RSpec.describe ScrapableResource, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      scrapable_resource = ScrapableResource.new(fields: 'sample_fields', url: 'http://example.com')
      expect(scrapable_resource).to be_valid
    end

    it 'is invalid without fields' do
      scrapable_resource = ScrapableResource.new(url: 'http://example.com')
      expect(scrapable_resource).to be_invalid
      expect(scrapable_resource.errors[:fields]).to include("can't be blank")
    end

    it 'is invalid without a url' do
      scrapable_resource = ScrapableResource.new(fields: 'sample_fields')
      expect(scrapable_resource).to be_invalid
      expect(scrapable_resource.errors[:url]).to include("can't be blank")
    end
  end
end
