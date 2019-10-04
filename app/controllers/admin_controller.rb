class AdminController < ApplicationController
    def search  
        command = Ifep::MainProgram.call(Ifep::Filters.headers, Ifep::Filters.form["body"], params)
    end
  
end
