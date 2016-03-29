require 'rails_helper'

describe ApplicationController do
  controller do
    def runtime_error
      raise
    end

    def not_found_error
      raise ActiveRecord::RecordNotFound
    end

    def routing_error
      raise ActionController::RoutingError, 'routing error'
    end

    def bad_request_error
      raise ApplicationController::BadRequestError, 'bad request error'
    end
  end

  context 'ApplicationController::BadRequestError が発生した時' do
    before do
      routes.draw { get 'bad_request_error' => 'anonymous#bad_request_error' }
    end

    it '400が返ってくること' do
      get :bad_request_error
      expect(response.status).to eq 400
    end
  end

  context 'ActiveRecord::RecordNotFound が発生した時' do
    before do
      routes.draw { get 'not_found_error' => 'anonymous#not_found_error' }
    end

    it '404が返ってくること' do
      get :not_found_error
      expect(response.status).to eq 404
    end
  end

  context 'ActionController::RoutingError が発生した時' do
    before do
      routes.draw { get 'routing_error' => 'anonymous#routing_error' }
    end

    it '404が返ってくること' do
      get :routing_error
      expect(response.status).to eq 404
    end
  end

  context 'RuntimeError が発生した時' do
    before do
      routes.draw { get 'runtime_error' => 'anonymous#runtime_error' }
    end

    it '500が返ってくること' do
      get :runtime_error
      expect(response.status).to eq 500
    end
  end
end
