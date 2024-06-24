class FetchOgJob < ApplicationJob
  queue_as :default

  def perform(*args)
    return unless args.kind_of?(Array) && args.first[:url].present?
    url = args.first[:url]

    @url = Url.find_by_url(url).presence ||  Url.new(args.first)

    metatags = OgService.new(url).getMetaTags
    @url.assign_attributes(metatags) if metatags.present?
    @url.save
  end
end
