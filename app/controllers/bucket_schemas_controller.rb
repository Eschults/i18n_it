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
    @bucket_schema.bucket_schema_name = @bucket_schema.slug
    @bucket_schema.bucket = @bucket
    @bucket_schema.cross_languages = true if bucket_schema_params[:cross_languages] == "true"
    authorize @bucket_schema
    # check if a bucket_schema exists with the same bucket_schema_name in current bucket
    if BucketSchema.where(bucket: @bucket, bucket_schema_name: @bucket_schema.bucket_schema_name).size > 0
      flash.now[:alert] = "This field name is already taken"
      render :new
    else
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
  end

  def bucket_schema_params
    params.require(:bucket_schema).permit(:bucket_schema_name, :col_type, :cross_languages)
  end
end
