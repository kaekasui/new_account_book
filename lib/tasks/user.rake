namespace :user do
  desc 'Add administrator authority to user.'
  task set_admin: :environment do
    begin
      id = ENV['USER_ID']
      fail "ENV['USER_ID'] is not found." unless id
      user = User.find(id)
      user.admin = true
      user.save!
    rescue => ex
      puts ex.message
    end
  end
end
