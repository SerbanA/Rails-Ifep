class AdminController < ApplicationController
    include Ifep
    def search
        command = Ifep::MainProgram.call(Ifep::Variables.headers, Ifep::Variables.body)
    end
  
end
