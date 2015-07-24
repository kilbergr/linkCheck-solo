class WebsitesController < ApplicationController
  def new
  	@website = Website.new
  end

  def create
    url = params.require(:website)[:url]
    website = Website.create(url: url)
    if website.save
    LinksWorker.perform_async(website.id)
    redirect_to website_path(website)
  	else 
  		render :new
  	end
  end



  def show
  	@website = Website.find_by_id(params[:id])
  	@links = @website.links
  end

  private

  	# def website_params
  	# 	params.require(:website).permit(:url)
  	# end
end
