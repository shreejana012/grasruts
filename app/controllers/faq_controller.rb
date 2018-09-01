class FaqController < ApplicationController

  def new
    @faqs = Faq.new
  end

  def create
    @campaign = Campaign.find_by_id params[:campaign_id]
    @faq = @campaign.faqs.create(faq_params)
    unless @faq.errors.messages.empty?
      flash[:error] = @faq.errors.messages.values.flatten
      return redirect_back(fallback_location: root_path)
    end
    redirect_to campaign_faq_list_path(params[:campaign_id], section: 'faq')
  end

  def edit
    @faqs = Faq.find_by_id params[:id]
  end

  def update
    @faq = Faq.find_by_id params[:id]
    @faq.update(faq_params)
    unless @faq.errors.messages.empty?
      flash[:error] = @faq.errors.messages.values.flatten
      return redirect_back(fallback_location: root_path)
    end
    redirect_to campaign_faq_list_path(params[:campaign_id], section: 'faq')
  end

  def destroy
    @faq = Faq.find_by_id params[:id]
    @faq.destroy
    redirect_to campaign_faq_list_path(params[:campaign_id], section: 'faq')
  end

  private
  def faq_params
    params.require(:faq).permit(:name, :description)
  end
end
