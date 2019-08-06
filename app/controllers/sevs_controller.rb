class SevsController < ApplicationController
  def index
  end

  def create
    @title = "Report"
    produce_report = false
    respond_to do |format|
      Rails.logger.level = 0

      @symptoms = []
      @prescription = []
      @drugsWithSymptoms = []
      # @sideEffects = []
      @commonSideEffects = []
      @drugList = params[:drugList]
      if @drugList == nil then format.all  { redirect_to("/404.html") } end

      @symptomList = params[:symptomList]
      if @symptomList == nil then format.all  { redirect_to("/404.html") } end

      #
      # build the prescription list for the view
      #
      @drugList.each do |drugId|
        begin found = Drug.find(drugId)
        @prescription.push(found)
        rescue
        end
      end if @drugList

      #
      # build the symptom list for the view
      #
      @symptomList.each do |symptom_id|
        begin found = Symptom.find(symptom_id)
        @symptoms.push(found)
        rescue
        end
      end if @symptomList

      #
      # build list of common side effects by going through
      # each listed drug and counting all the symptoms
      #
      @prescription.each do |drug|
        SideEffect.where(drug_id: drug.id).each do |se|
          cse=@commonSideEffects.find { |cse| cse[:side].symptom_id==se.symptom_id }
          if cse # != nil
            cse[:count] += 1
          else
            @commonSideEffects.push( { :side  => se, :count => 1} )
          end
        end
      end
      #
      # top ten-ish common side effects
      #
      @commonSideEffects = @commonSideEffects.sort_by { |cse| -cse[:count] }
      @commonSideEffects.keep_if { |c| c[:count] > 1 }
      if @commonSideEffects.length >= 10  then
        t = @commonSideEffects[10][:count]
        @commonSideEffects.keep_if { |c| c[:count] >= t }
      end

      #
      # Build list of drugs with matching symptoms
      # check each symptom across all listed drugs
      #
      @symptoms.each do |symptom|
        @prescription.each do |drug|
          SideEffect.where(:drug_id => drug.id, :symptom_id => symptom.id).each do |se|
            dws = @drugsWithSymptoms.find { |dws| dws[:drug].id == se.drug_id }
            if dws
              dws[:symptoms].push(symptom)
            else
              @drugsWithSymptoms.push({ :drug => drug,
                                        :symptoms => [ symptom ] } )
            end
          end
        end
      end
      format.html { render "generate_report" }
    end # respond_to
  end # def create
end
