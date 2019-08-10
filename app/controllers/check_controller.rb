class CheckController < ApplicationController
  def check
    type = params[:type]
    text = params[:text]
    count = 10

    out = []

    if type == 'drugs'
    then
      Drug.where("lower(name) LIKE lower(?)", "%#{text}%").take(count).each do |d|
        out.push(d)
      end
    elsif type == 'symptoms'
    then
      Symptom.where("lower(name) LIKE lower(?)", "%#{text}%").take(count).each do |s|
        out.push(s)
      end
    end
    
    respond_to do |format|
      format.json { render :json => out }
      format.html { render :html => out.to_json }
    end
  end
end

