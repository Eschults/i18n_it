class BucketsController < ApplicationController
  def new
    @bucket = Bucket.new
    @companies = Company.all
  end

  def create
    @company = Company.find_or_create_by(company_name: params[:company_name])

    @bucket = Bucket.new(bucket)
  end
end
