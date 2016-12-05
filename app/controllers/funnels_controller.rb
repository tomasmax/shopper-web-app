class FunnelsController < ApplicationController
  def index
    @funnel = Applicant.funnel_time_analytics(start_date: start_date, end_date: end_date)

    respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
      
    end
  end

  private

  # generates a formatted version of the funnel for display in d3
  def formatted_funnel
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << {label: date, value: count}
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end

  #Set default start_date and end_date parameters, in case they are blank start_date = beginning of the month and end_date = current day + one day
  def start_date
    params[:start_date] ? params[:start_date].to_datetime : DateTime.now.beginning_of_month
  end

  def end_date
    params[:end_date] ? params[:end_date].to_datetime : DateTime.now + 1.day
  end

end
