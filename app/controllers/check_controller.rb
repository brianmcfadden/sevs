class CheckController < ApplicationController
  def check
    type = params[:type]
    text = params[:text]

    out = []

    if type == 'drugs'
    then
      if text == nil
      then
        out=[Drug.new]
      else
        Drug.where("lower(name) LIKE lower(?)", "%#{text}%").order(:name).each do |d|
          out.push(d)
        end
      end
    elsif type == 'symptoms'
    then
      if text == nil
      then
        out=[Symptom.new]
      else
        Symptom.where("lower(name) LIKE lower(?)", "%#{text}%").order(:name).each do |s|
          out.push(s)
        end
      end
    end
    
    respond_to do |format|
      format.json { render :json => out }
      format.html { render :html => out.to_json }
    end
  end
end

