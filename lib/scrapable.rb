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
    end

    result
  end
end
