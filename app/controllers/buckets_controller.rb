class BucketsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @buckets = @project.buckets
  end

  def new
    @bucket = Bucket.new
    @companies = Company.all
  end

  def create
    @company = Company.find_or_create_by(company_name: params[:company_name])

    @bucket = Bucket.new(bucket_params)
  end

  def edit
    @bucket = Bucket.find(params[:id])
    @translation_keys = @bucket.translations.map { |translation| translation.translation_key }.uniq
  end

  private

  def bucket_params
    params.require(:bucket).permit(:bucket_name, :kind)
  end
end
