class NewsController < ApplicationController

  def index
    @campaign = current_user.campaigns.find_by_id(params[:campaign_id])
    @news = @campaign.campaign_updates.kept
  end

  def new
    @news = CampaignUpdate.new
  end

  def create
    @campaign = Campaign.find_by_id params[:campaign_id]
    @news = @campaign.campaign_updates.create(news_params)
    unless @news.errors.messages.empty?
      flash[:error] = @news.errors.messages.values.flatten
      return redirect_back(fallback_location: root_path)
    end
    redirect_to campaign_news_list_path(params[:campaign_id], section: 'news')
  end

  def edit
    @news = CampaignUpdate.find_by_id params[:id]
  end

  def update
    @news = CampaignUpdate.find_by_id params[:id]
    @news.update(news_params)
    unless @news.errors.messages.empty?
      flash[:error] = @news.errors.messages.values.flatten
      return redirect_back(fallback_location: root_path)
    end
    redirect_to campaign_news_list_path(params[:campaign_id], section: 'news')
  end

  def destroy
   @news = CampaignUpdate.find_by_id params[:id]
   @news.discard
   redirect_back(fallback_location: root_path)
  end

  private
  def news_params
    params.require(:campaign_update).permit(:name, :description)
  end
end