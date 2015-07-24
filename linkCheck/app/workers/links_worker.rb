class LinksWorker
	include Sidekiq::Worker

	def perform(site_id)
		website = Website.find_by_id(site_id)
		#site_open = File.open(website.url, 'r')
		html = Nokogiri::HTML(Typhoeus.get(website.url).response_body)
		html.css('a').each do |link|
			link_href = link.attributes['href'].value
			if link_href.starts_with? '/'
				link_href = website.url + link_href
			elsif (link_href.starts_with? 'http://', 'https://', 'www.')
				response = Typhoeus.get(link_href)
				website.links.create(url: link_href, http_res: response.response_code)
			end

		end
	end

end