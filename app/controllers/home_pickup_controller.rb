class HomePickupController < ApplicationController
  before_action :authenticate_user!


  def create
    contribution = Contribution.find_by_uuid params[:contribution_id]
    contribution.gateway = Contribution.gateways['cash_pickup']
    contribution.ref_id = SecureRandom.uuid,
    contribution.state = Contribution.states['pending']
    contribution.save
    redirect_to campaign_contribution_payment_success_path(params[:campaign_id], params[:contribution_id])
  end

  def update
  end
end
