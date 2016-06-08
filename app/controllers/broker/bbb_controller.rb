require_dependency "broker/application_controller"
require_dependency "bigbluebutton_api"

module Broker
  class BbbController < ::ApplicationController
    before_action :init_bigbluebutton

    include Broker::BbbHelper

    def index
    end

    def recording_list
      response_data = bbb_get_recordings(params[:id])
      render_response(response_data)
    end
    
    def recording
      render_response({:hello => 'world'})
    end

    def recording_publish
      render_response({:hello => 'world'})
    end

    def recording_delete
      render_response({:hello => 'world'})
    end
    
    private
    def render_response(_response, status = :ok)
      logger.info _response
      begin
        respond_to do |format|
          format.html { render 'index'} #index.html.erb
          format.xml  { render :xml => _response.to_xml, :status => status}
          format.json { render :json => _response.to_json, :status => status}
        end
      rescue
        render_error( {:realm => "BigBlueButton", :error => "unsupported_format", :error_description => "Only JSON/XML formats supported"}, :not_found )
      end
    end

    def render_error(error, status)
      respond_to do |format|
        format.json { render :json => error.to_json(), :status => status}
      end
    end

    private
    def init_bigbluebutton
      if !@bbb 
        logger.info "initializing @bbb"
        if @bbb_endpoint && @bbb_secret
          begin
            @bbb ||= BigBlueButton::BigBlueButtonApi.new(@bbb_endpoint, @bbb_secret, "0.8", true)
          rescue BigBlueButton::BigBlueButtonException => exc
            logger.info "Message for the log file #{exc.key}: #{exc.message}"
            @bbb = nil
          end
        else
          logger.info "Missing @bbb_endpoint or @bbb_secret"
          @bbb = nil
        end
      end
    else
      logger.info "@bbb already initialized"
    end
  end
end
