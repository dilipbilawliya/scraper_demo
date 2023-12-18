class Scrapable
  attr_reader :url, :fields

  def Initialize(url, fields)
    @url = url
    @fields = fields
  end

  def self.scrape(url, fields)
    response = HTTParty.get(url)
    doc = Nokogiri::HTML(response.body)
    result = process_fields(doc, fields)
    ScrapableResource.create!(url: url, fields: result)
    
    result
  end

  def self.process_fields(doc, fields)
    result = {}

    fields.each do |field_name, selector|
      result[field_name] = doc.css(selector).text.strip
      result[field_name] = process_meta_fields(doc, selector) if field_name == 'meta'
    end

    result
  end

  def self.process_meta_fields(doc, meta_tags)
    meta_result = {}

    meta_tags.each do |meta_tag|
      meta_result[meta_tag] = doc.at_css("meta[name='#{meta_tag}']")&.attribute('content')&.value
    end

    meta_result
  end
end

