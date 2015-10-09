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
      @translations = Translation.where(translation_key: params[:key]).joins("LEFT JOIN buckets b ON translations.bucket_id = b.id")
    elsif params[:project]
      @translations = Translation.where(bucket: Bucket.where(project_id: params[:project])).joins("LEFT JOIN buckets b ON translations.bucket_id = b.id")
    elsif params[:bucket]
      @translations = Translation.where(bucket_id: params[:bucket]).joins("LEFT JOIN buckets b ON translations.bucket_id = b.id")
    else
      @translations = Translation.all.joins("LEFT JOIN buckets b ON translations.bucket_id = b.id")
    end
    @translations = @translations.group_by { |t| t.translation_key }.values.map { |group| { ids: group.map { |tr| tr.id }, translation_key: group.first.translation_key, bucket_name: group.first.bucket.bucket_name, project_name: group.first.bucket.project.project_name, company_name: group.first.bucket.project.company.company_name, translations: eval("{" + group.map {|t| "'#{t.language.language_key}' => '#{t.text}'"}.join(", ") + "}"), sub_bucket_name: group.first.bucket.kind == "d" ? group.first.sub_bucket.sub_bucket_name : ""}}
  end

  def project_translations
    @project = Project.find_by(uuid: params[:project_uuid])
    @buckets = @project.buckets
    @translations = Translation.where(bucket: @buckets)
    if params[:bucket_id]
      @translations = @translations.where(bucket_id: params[:bucket_id])
      if params[:key]
        @translations = @translations.where(translation_key: params[:key])
      end
    elsif params[:key]
      @translations = @translations.where(translation_key: params[:key])
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

  def project_translations_for_detailed_buckets
    @project = Project.find_by(uuid: params[:project_uuid])
    @buckets = @project.buckets
    @sub_buckets = SubBucket.where(bucket: @buckets)
    if params[:bucket_id]
      @sub_buckets = @sub_buckets.where(bucket_id: params[:bucket_id])
      if params[:key]
        @sub_buckets = @sub_buckets.where(sub_bucket_name: params[:key])
      end
    elsif params[:key]
      @sub_buckets = @sub_buckets.where(sub_bucket_name: params[:key])
    end
  end
end
