class WebsitesController < ApplicationController
  def new
  	@website = Website.new
  end

  def create
  	@website=Website.new(website_params)
  	if @website.save
  		redirect_to show_path(@website)
  	else 
  		render :new
  	end
  end

  def show
  	@website = Website.find_by_id(params[:id])
  end

  private

  	def website_params
  		params.require(:website).permit(:url)
  	end
end
