class SevsController < ApplicationController
  def index
    @side_effects = SideEffect.all
    @drugs = Drug.all
    @symptoms = Symptom.all
  end
end
