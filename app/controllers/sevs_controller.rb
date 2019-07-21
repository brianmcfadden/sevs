class SevsController < ApplicationController
  def index
    @side_effects = SideEffect.all
    @drugs = Drug.all
    @symptoms = Symptom.all
  end

  def create
    respond_to do |format|
      format.html { redirect_to("/404.html") }
    end
  end
end
