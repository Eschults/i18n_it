class BucketSchemasController < ApplicationController
  def new
    @bucket = Bucket.find(params[:bucket_id])
    @bucket_schema = BucketSchema.new
    @bucket_schema.bucket = @bucket
    authorize @bucket_schema
  end

  def create
    @bucket = Bucket.find(params[:bucket_id])
    @bucket_schema = BucketSchema.new(bucket_schema_params)
    @bucket_schema.bucket = @bucket
    authorize @bucket_schema
    if @bucket_schema.save
      if @bucket.sub_buckets.size == 0
        redirect_to new_bucket_sub_bucket_path(@bucket)
      else
        redirect_to edit_bucket_path(@bucket)
      end
    else
      render :new
    end
  end

  def bucket_schema_params
    params.require(:bucket_schema).permit(:bucket_schema_name, :col_type)
  end
end
