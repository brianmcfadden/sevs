# This file contains all the record creation needed to seed the database
# with values retrieved from SIDER.
#
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# This will take a long time to run.  Don't surprised if it takes a
# longer time than you had planned.  My own load takes:
# real	24m31.892s
#
# Arguments:
#
# source={directory}
#   By default, we will read data from the SIDER database on the net,
#   located at "http://sideeffects.embl.de/media/download/".  If you
#   have downloaded the database and wish to install locally, you can
#   provide a "source=dbdir" parameter, where dbdir is the location
#   on the local filesystem of the files drug_names.tsv and
#   meddra_all_se.tsv.gz
#   Ex: rake db:seed source=/home/bob/sider_db
#
# keep - TBD
#   By default, the old tables for drugs, symptoms and side effects will
#   be deleted.  Using "keep=true", the tables will not be removed, and
#   the tables will be reloaded as needed
#
# show_output
#   By default, no output is produced to stdout.  Using this flag, stdout
#   will print relevant messages about the data being added
#   Ex: rake db:seed show_output=true
#

require 'open-uri'

@show_output = false
@show_output = true if ENV["show_output"]
def info(out)
  puts out if @show_output
end

source = "http://sideeffects.embl.de/media/download"
if ENV["source"]
then
  source = ENV["source"]
end

#unless ENV["keep"]
  info "Clearing old tables"
  SideEffect.delete_all
  Symptom.delete_all
  Drug.delete_all
#end

info "Importing SIDER Drug table"

drugfile = open( source + "/drug_names.tsv" )
tsvfile = TSV.parse(drugfile).without_header
tsvfile.map do |row|
  compound_id = row[0][3..].to_i
  drug_name = row[1]
  drug = Drug.new
  drug.id = compound_id
  drug.name = drug_name
  if drug.save(:validate=>false)
  then
    info("Drug " + compound_id.to_s + ": " + drug_name)
  else
    STDERR.puts("FAILED to save drug " + compound_id.to_s + ": " + drug_name)
  end
end
drugfile.close

info "Importing SIDER Symptoms and Side Effects"

segzfile = open( source + "/meddra_all_se.tsv.gz" )
sefile = Zlib::GzipReader.new( segzfile )
tsvfile = TSV.parse(sefile).without_header
tsvfile.map do |row|
  compound_id = row[0][3..].to_i
  umls_concept_id = row[4][1..].to_i
  if umls_concept_id == 0 then umls_concept_id = row[2][1..].to_i end
  side_effect_name = row[5]
  if not Symptom.exists?(umls_concept_id)
    symptom = Symptom.new
    symptom.id = umls_concept_id
    symptom.name = side_effect_name
    info("Symptom " + umls_concept_id.to_s + ": " + side_effect_name)
    if symptom.save(:validate=>false)
    then
      info("Symptom " + umls_concept_id.to_s + ": " + side_effect_name)
    else
      STDERR.puts("FAILED to save symptom " + umls_concept_id.to_s + ": " + side_effect_name)
    end
  end
  SideEffect.create(drug_id: compound_id, symptom_id: umls_concept_id)
  info("Side Effect " + compound_id.to_s + " <=> " + umls_concept_id.to_s)
end

sefile.close

exit 0
