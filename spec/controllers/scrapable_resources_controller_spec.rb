require 'rails_helper'

RSpec.describe ScrapableResourcesController, type: :controller do
  describe 'POST #scrape' do
    let(:url) { 'http://example.com' }
    let(:fields) { %w[title description] }
    let(:meta_fields) {{'meta' => ['google_site', 'keywords']}}
    let(:scraped_result) { { title: 'Example Title', description: 'Lorem Ipsum' } }

    before do
      allow(Scrapable).to receive(:scrape).with(url, fields).and_return(scraped_result)
      allow(Scrapable).to receive(:scrape).with(url, meta_fields).and_return(scraped_result)
    end

    it 'calls Scraper.scrape with the provided URL and fields' do
      post :scrape, params: { url: url, fields: fields }
      expect(Scrapable).to have_received(:scrape).with(url, fields)
    end

    it 'calls Scraper.scrape with the provided URL and fields' do
      post :scrape, params: { url: url, fields: meta_fields }
      expect(Scrapable).to have_received(:scrape).with(url, meta_fields)
    end
  end
end

