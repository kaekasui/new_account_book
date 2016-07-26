# frozen_string_literal: true
require 'rails_helper'
require 'rake'

describe 'user tasks' do
  before :all do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'lib/tasks/user', [Rails.root.to_s]
    Rake::Task.define_task(:environment)
  end

  context 'user:set_admin' do
    let!(:user) { create(:email_user) }

    context 'when set the user id' do
      before do
        ENV['USER_ID'] = user.id.to_s
      end

      it 'add administrator authority to the user' do
        @rake['user:set_admin'].execute

        user.reload
        expect(user.admin?).to be_truthy
      end
    end

    context 'when not set the user id' do
      it 'add administrator authority to the user' do
        @rake['user:set_admin'].execute

        user.reload
        expect(user.admin?).to be_falsey
      end
    end
  end
end
