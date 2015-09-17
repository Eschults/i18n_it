class ApisController < ApplicationController
  respond_to :json

  def translations
    if params[:key]
      @translations = Translation.where(translation_key: params[:key])
    elsif params[:project]
      @translations = Translation.joins('INNER JOIN buckets b ON b.id = bucket_id INNER JOIN projects p ON p.id = b.project_id').where("project_id = :project",   {project: params[:project]})
    elsif params[:bucket]
      @translations = Translation.where(bucket_id: params[:bucket])
    else
      @translations = Translation.all
    end
  end

  def t
    if params[:key]
      @translations = Translation.where(translation_key: params[:key])
    elsif params[:project]
      @translations = Translation.joins('INNER JOIN buckets b ON b.id = bucket_id INNER JOIN projects p ON p.id = b.project_id').where("project_id = :project",   {project: params[:project]})
    elsif params[:bucket]
      @translations = Translation.where(bucket_id: params[:bucket])
    else
      @translations = Translation.all
    end
    @translations_grouped_by_key = []
    @translations.each do |translation|
      test = []
      translation.translations_including_self_in_array.each do |t|
        test << translation if @translations_grouped_by_key.include? t
      end
      @translations_grouped_by_key << translation unless test.size > 0
    end
  end

  def tt
    if params[:key]
      @sub_buckets = SubBucket.where(sub_bucket_name: params[:key])
    elsif params[:project]
      @translations = Translation.joins('INNER JOIN buckets b ON b.id = bucket_id INNER JOIN projects p ON p.id = b.project_id').where("project_id = :project",   {project: params[:project]})
    elsif params[:bucket]
      @translations = Translation.where(bucket_id: params[:bucket])
    else
      @sub_buckets = SubBucket.all
    end
  end
end
