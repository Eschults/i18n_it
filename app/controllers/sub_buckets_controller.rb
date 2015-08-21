class SubBucketsController < ApplicationController
  def new
    @bucket = Bucket.find(params[:bucket_id])
    @sub_bucket = SubBucket.new
  end

  def create
    @bucket = Bucket.find(params[:bucket_id])
    @sub_bucket = SubBucket.new(sub_bucket_params)
    @sub_bucket.bucket = @bucket
    if @sub_bucket.save
      redirect_to edit_bucket_path(@bucket)
    else
      render :new
    end
  end

  private

  def sub_bucket_params
    params.require(:sub_bucket).permit(:sub_bucket_name)
  end
end
