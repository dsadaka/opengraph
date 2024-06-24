# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'
require 'net/http'
class OgService
  attr_accessor :url

  def initialize(url)
    @url = url
  end
  def getMetaTags
    return nil if url.blank?
    document = getDocument
    return nil if document.nil?

    extractData(document)
  end

  private

  def extractData(document)
    result = Hash.new
    result[:title] = document.at('meta[property="og:title"]')['content'] if document.at('meta[property="og:title"]')
    result[:ogtype] = document.at('meta[property="og:type"]')['content'] if document.at('meta[property="og:type"]')
    result[:url] = url
    result[:image] = document.at('meta[property="og:image"]')['content'] if document.at('meta[property="og:image"]')
    result[:description] = document.at('meta[property="og:description"]')['content'] if document.at('meta[property="og:description"]')

    result
  end

  def getDocument
    document = Nokogiri::HTML(URI.open(url, :open_timeout => 10, :read_timeout => 10).read)
    document.encoding = 'UTF-8'
    document
  end
end
