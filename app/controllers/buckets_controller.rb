class BucketsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
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
      redirect_to edit_bucket_path(@bucket)
    else
      render :new
    end
  end

  def edit
    @bucket = Bucket.find(params[:id])
    @translation_keys = @bucket.translations.map { |translation| translation.translation_key }.uniq
  end

  def update
    @bucket = Bucket.find(params[:id])
    @translation_keys = @bucket.translations.map { |translation| translation.translation_key }.uniq
    @translation_keys.each do |key|
      @bucket.project.languages.each do |language|
        translation = Translation.get(key, language) unless params[:translation_keys][:value] == ""
        unless translation.nil?
          translation.translation_key = params[:translation_keys][key][:value] unless translation.translation_key == params[:translation_keys][key][:value] || params[:translation_keys][key][:value] == ""
          translation.text = params[:translation_keys][key][language.language_key] unless translation.translation_key == params[:translation_keys][key][language.language_key]
          translation.bucket = @bucket
          translation.language = language
          translation.save
        end
      end
    end
    unless params[:translation_keys][:new_translation_key][:value] == ""
      @bucket.project.languages.each do |language|
        Translation.create(language: language, bucket: @bucket, translation_key: params[:translation_keys][:new_translation_key][:value], text: params[:translation_keys][:new_translation_key][language.language_key]) unless params[:translation_keys][:new_translation_key][language.language_key] == ""
      end
    end
    redirect_to edit_bucket_path(@bucket)
  end

  private

  def bucket_params
    params.require(:bucket).permit(:bucket_name, :kind)
  end
end
