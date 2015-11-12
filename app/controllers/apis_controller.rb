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
    @output = PG.connect(
      dbname: Rails.configuration.database_configuration[Rails.env]["database"],
      user: Rails.configuration.database_configuration[Rails.env]["username"],
      password: Rails.configuration.database_configuration[Rails.env]["password"],
      host: Rails.configuration.database_configuration[Rails.env]["host"],
      port: Rails.configuration.database_configuration[Rails.env]["port"]
    ).exec("
      SELECT
          json_agg(t.id) as ids,
          t.translation_key,
          sb.sub_bucket_name,
          p.project_name,
          t.bucket_id,
          json_object_agg( l.language_key, t.text ) as translations
      FROM translations t
      LEFT JOIN languages l ON l.id = t.language_id
      LEFT JOIN buckets b ON b.id = t.bucket_id
      LEFT JOIN sub_buckets sb ON sb.id = t.sub_bucket_id
      LEFT JOIN projects p ON p.id = b.project_id
      WHERE 1=1 " +
      (params[:project] ? " AND p.id = " + params[:project] : "") +
      (params[:bucket] ? " AND b.id = " + params[:bucket] : "") +
      "GROUP BY
          t.bucket_id,
          t.translation_key,
          sb.sub_bucket_name,
          p.project_name
    ")
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
