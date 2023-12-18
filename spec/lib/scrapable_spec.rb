require 'rails_helper'

RSpec.describe Scrapable, type: :class do
  let(:url) { 'http://example.com' }
  let(:fields) { { 'h1' => 'Title', 'p' => 'Content' } }
  let(:meta_fields) {{'meta' => ['google_site', 'keywords']}}
  let(:html_content) {'<html><head><meta name="google_site" content="google"></head><body><h1>Title</h1><p>Content</p></body></html>'}

  describe '.scrape' do
    before do
      allow(HTTParty).to receive(:get).with(url).and_return(double('response', body: html_content))
      allow(Nokogiri::HTML).to receive(:parse).with(html_content).and_return(Nokogiri::HTML(html_content))
    end

    it 'fetches and processes the content from the specified URL with meta' do
      allow(ScrapableResource).to receive(:create!).with(url: url, fields: { 'meta' => {'google_site' => 'google', 'keywords' => nil} })
      expect(Rails.cache).to receive(:fetch).with("#{url}/#{meta_fields}", expires_in: 2.hours)
      Scrapable.scrape(url, meta_fields)
    end

    it 'fetches and processes the content from the specified URL' do
      allow(ScrapableResource).to receive(:create!).with(url: url, fields: { 'h1' => 'Title', 'p' => 'Content'})
      expect(Rails.cache).to receive(:fetch).with("#{url}/#{fields}", expires_in: 2.hours)
      Scrapable.scrape(url, fields)
    end
  end
end
