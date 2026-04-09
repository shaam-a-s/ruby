class ConversionsController < ApplicationController
  def convert
    data = JSON.parse(File.read(Rails.root.join('config/units.json')))

    value = params[:value].to_f
    type = params[:type]

    result =
      case type
      when "m_to_km"
        value * data["length"]["meter_to_kilometer"]
      when "g_to_kg"
        value * data["weight"]["gram_to_kilogram"]
      else
        "Invalid type"
      end

    render json: { input: value, type: type, result: result }
  end
end