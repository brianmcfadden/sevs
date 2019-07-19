class SevsController < ApplicationController
  def main
    @side_effects = SideEffect.all
    @drugs = Drug.all
    @symptoms = Symptom.all
  end
end
