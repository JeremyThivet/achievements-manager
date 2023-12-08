class ApplicationController < ActionController::API

    def return_created(result)
        render json: build_content_response(result), status: :created
    end

    def return_error_response(result)
        case result.error_type
        when Result::BAD_USER_INPUT
            return_bad_request(result.errors)
        when Result::INPUT_LED_TO_CONFLICT
            return_conflict(result.errors)
        else
            return_internal_server_error(result.errors)
        end

    end

    def return_bad_request(result)
        render json: build_errors_response(result), status: :bad_request
    end

    def return_conflict(result)
        render json: build_errors_response(result), status: :conflict
    end

    def return_internal_server_error(result)
        render json: build_errors_response(result), status: :internal_server_error
    end

    def build_errors_response(data)
        {
            errors: data
        }
    end

    def build_content_response(data)
        {
            content: data
        }
    end

end