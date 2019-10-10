class AdminController < ApplicationController
    before_action :generate_uuid

    def generate_uuid
        params[:UUID] = SecureRandom.uuid
        @UUID = params[:UUID]
    end
  
    def search_results 
        command = Ifep::MainProgram.call(Ifep::Filters.headers, Ifep::Filters.form["body"], params[:search_value])
        @search_value = params[:search_value]
        @lawyer = command.result
    end

    def validate_lawyer
        if lawyer_ok?
            p "This lawyer's data is OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        else 
            p "This lawyer's data is NOT-OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        end
    end
    
    private
    
    def lawyer_ok?
        params[:commit] == "OK"
    end

end
