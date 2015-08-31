class ApisController < ApplicationController
  respond_to :json

  def translations
    if params[:key]
      @translations = Translation.where(translation_key: params[:key])
    else
      @translations = Translation.all
    end
  end

  def t
    if params[:key]
      @translations = Translation.where(translation_key: params[:key])
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
      @translations = Translation.where(translation_key: params[:key])
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
end
