class AdminController < ApplicationController
    before_action :generate_uuid

    def generate_uuid
        params[:UUID] = SecureRandom.uuid
        @UUID = params[:UUID]
    end
  
    def search 
        command = Ifep::MainProgram.call(Ifep::Filters.headers, Ifep::Filters.form["body"], params[:search_value])
        @lawyer = command.result
    end

    def validate_lawyer
        if params[:commit] == "OK"
            p "This lawyer's data is OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        elsif params[:commit] == "NOT-OK"
            p "This lawyer's data is NOT-OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        end
    end
    
end
