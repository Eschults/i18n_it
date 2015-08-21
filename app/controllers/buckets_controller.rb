class BucketsController < ApplicationController
  def index
    @buckets = Bucket.all
  end

  def new
    @project = Project.find(params[:project_id])
    @bucket = Bucket.new
  end

  def create
    @project = Project.find(params[:project_id])
    @bucket = Bucket.new(bucket_params)
    @bucket.project = @project
    if @bucket.save
      if @bucket.kind == "s"
        redirect_to edit_bucket_path(@bucket)
      elsif @bucket.kind == "d"
        redirect_to new_bucket_bucket_schema_path(@bucket)
      end
    else
      render :new
    end
  end

  def edit
    @bucket = Bucket.find(params[:id])
    @translation_keys = @bucket.translations.map { |translation| translation.translation_key }.uniq
    # if bucket.kind == "d"
    @bucket_schemas = @bucket.bucket_schemas
    @sub_buckets = @bucket.sub_buckets
  end

  def update
    @bucket = Bucket.find(params[:id])
    @sub_bucket = SubBucket.find(params[:sub_bucket_id]) if @bucket.kind == "d"
    @translation_keys = @bucket.translations.map { |translation| translation.translation_key }.uniq
    @translation_keys.each do |key|
      @bucket.project.languages.each do |language|
        if @bucket.kind == "s"
          translation = Translation.find_or_create_by(translation_key: key, language: language, bucket: @bucket) unless params[:translation_keys][:value] == ""
        elsif @bucket.kind == "d"
          translation = Translation.find_or_create_by(translation_key: key, language: language, bucket: @bucket, sub_bucket: @sub_bucket)
          key = key.split("_").map { |word| word.capitalize }.join(' ')
        end
        unless translation.nil?
          translation.translation_key = params[:translation_keys][key][:value] unless translation.translation_key == params[:translation_keys][key][:value]
          translation.text = params[:translation_keys][key][language.language_key] unless translation.translation_key == params[:translation_keys][key][language.language_key]
          translation.bucket = @bucket
          translation.sub_bucket = @sub_bucket if @bucket.kind == "d"
          translation.language = language
          translation.save
        end
      end
    end
    if @bucket.kind == "s"
      unless params[:translation_keys][:new_translation_key][:value] == ""
        @bucket.project.languages.each do |language|
          Translation.create(language: language, bucket: @bucket, translation_key: params[:translation_keys][:new_translation_key][:value], text: params[:translation_keys][:new_translation_key][language.language_key]) unless params[:translation_keys][:new_translation_key][language.language_key] == ""
        end
      end
    elsif @bucket.kind == "d"
      @bucket.bucket_schemas.each do |bucket_schema|
        @bucket.project.languages.each do |language|
          unless Translation.find_by(language: language, bucket: @bucket, sub_bucket: @sub_bucket, translation_key: params[:translation_keys][bucket_schema.bucket_schema_name][:value], text: params[:translation_keys][bucket_schema.bucket_schema_name][language.language_key])
            Translation.create(language: language, bucket: @bucket, sub_bucket: @sub_bucket, translation_key: params[:translation_keys][bucket_schema.bucket_schema_name][:value], text: params[:translation_keys][bucket_schema.bucket_schema_name][language.language_key]) unless params[:translation_keys][bucket_schema.bucket_schema_name][language.language_key] == ""
          end
        end
      end

    end
    redirect_to edit_bucket_path(@bucket)
  end

  private

  def bucket_params
    params.require(:bucket).permit(:bucket_name, :kind)
  end
end
