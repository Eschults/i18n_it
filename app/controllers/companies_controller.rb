class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
  end

  def show
    @company = Company.find(params[:id])
    authorize @company
  end
end
