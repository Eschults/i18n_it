class TranslationsController < ApplicationController

  def create
    @translation = Translation.new(translation_params)
  end

  private

  def translation_params
    params.require(:translation).permit(:key, :value, :bucket, :sub_bucket, :language)
  end
end
