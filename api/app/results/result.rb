class Result < Struct

    # Errors types
    BAD_USER_INPUT = 0
    INPUT_LED_TO_CONFLICT = 1

    class << self
      def with_members(*members)
        new(*members, :errors, :error_type, keyword_init: true)
      end

        def initialize_with_errors(errors, type)
            new(:errors, :error_type).new(errors, type)
        end
   
      def success(*values)
        new(*values)
      end
   
      def failure(errors, type)
        new(errors: errors, error_type: type)
      end
    end
   
    def initialize(*args)
      super(*args)
      self.errors ||= []
    end

    def errors?
        errors.any?
    end
end