require 'csv'

CSV.generate do |csv|
  @records.each do |record|
    csv << [
      record.published_at,
      record.category.try!(:name),
      record.breakdown.try!(:name),
      record.place.try!(:name),
      record.charge,
      record.memo,
      record.tags.pluck(:name).join(',')
    ]
  end
end
