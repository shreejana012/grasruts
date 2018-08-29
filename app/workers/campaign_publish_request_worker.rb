class CampaignPublishRequestWorker
  include Sidekiq::Worker

  def perform(id)
    CampaignMailer.review_email(id).deliver_now
  end
end
