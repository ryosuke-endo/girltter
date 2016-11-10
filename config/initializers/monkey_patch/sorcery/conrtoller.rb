module Sorcery
  module Controller
    module InstanceMethods
      # current_userでupdateしないようにするため
      def current_user
        unless defined?(@current_user)
          @current_user = login_from_session || login_from_other_sources || nil
          @current_user&.readonly!
        end
        @current_user
      end
    end
  end
end
