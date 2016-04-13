namespace :counter do
  desc 'Use counter_culture_fix_counts of counter_culture.'
  task init: :environment do
    begin
      Breakdown.counter_culture_fix_counts
      CategorizePlace.counter_culture_fix_counts
    rescue => ex
      puts ex.message
    end
  end
end
