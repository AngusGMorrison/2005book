module Chain::Validations
    extend ActiveSupport::Concern

    included do 
        
      def chain_doesnt_already_exist?
        users = self.user
      end
        
    end

  end